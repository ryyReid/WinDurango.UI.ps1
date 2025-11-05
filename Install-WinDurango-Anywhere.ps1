<#
.SYNOPSIS
    Downloads, builds, and launches WinDurango.UI anywhere on any Windows PC.

.FEATURES
    • Asks for install folder
    • Clones from GitHub (or uses existing)
    • Verifies .NET 8 SDK
    • Runs pre-build script (optional)
    • Builds with dotnet
    • Launches GUI
    • Zero hard-coded paths
#>

[CmdletBinding()]
param()

# ── CONFIG ─────────────────────────────────────────────────────────────────────
$RepoUrl         = "https://github.com/YourUsername/WinDurango.git"  # ← CHANGE THIS
$SolutionFile    = "WinDurango.sln"
$BuildConfig     = "Release"
$Platform        = "x64"
$ExeRelativePath = "gui\bin\$Platform\$BuildConfig\net8.0-windows10.0.26100.0\WinDurango.UI.exe"
$PreBuildScript  = "gui\BuildScripts\build.bat"

# ── HELPER FUNCTIONS ───────────────────────────────────────────────────────────
function Write-Info    { param([string]$m) Write-Host $m -ForegroundColor Cyan }
function Write-Success { param([string]$m) Write-Host $m -ForegroundColor Green }
function Write-Warn    { param([string]$m) Write-Host $m -ForegroundColor Yellow }
function Write-ErrorMsg{ param([string]$m) Write-Host $m -ForegroundColor Red }

function Get-ValidFolder {
    do {
        $path = Read-Host "Enter install folder (e.g. C:\WinDurango)"
        $path = $path.Trim('"').Trim()
        if (-not $path) { Write-Warn "Path cannot be empty." ; continue }
        try { $full = Resolve-Path $path -ErrorAction Stop } catch { $full = $null }
        if ($full) { Write-Warn "Folder already exists: $full" }
        $parent = Split-Path $path -Parent
        if ($parent -and -not (Test-Path $parent)) {
            Write-Warn "Parent folder does not exist: $parent"
            continue
        }
        return $path
    } while ($true)
}

# ── STEP 1: ASK FOR INSTALL LOCATION ───────────────────────────────────────────
Clear-Host
Write-Host "=== WinDurango.UI Installer ===" -ForegroundColor Magenta
$InstallRoot = Get-ValidFolder
$InstallRoot = (Resolve-Path (Split-Path $InstallRoot -Parent)).Path
$ProjectRoot = Join-Path $InstallRoot (Split-Path $InstallRoot -Leaf)

Write-Host "`nInstalling to: $ProjectRoot`n" -ForegroundColor Green

# Create folder
New-Item -ItemType Directory -Path $ProjectRoot -Force | Out-Null

# ── STEP 2: CLONE REPO (if not exists) ─────────────────────────────────────────
Push-Location $ProjectRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-ErrorMsg "Git is not installed or not in PATH."
    Write-Host "Download: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path ".git")) {
    Write-Info "Cloning repository..."
    git clone $RepoUrl . --depth 1
    if ($LASTEXITCODE -ne 0) {
        Write-ErrorMsg "Failed to clone repository."
        Pop-Location
        exit 1
    }
} else {
    Write-Warn "Existing repo found – skipping clone."
}

# ── STEP 3: VALIDATE SOLUTION ──────────────────────────────────────────────────
$SolutionPath = Join-Path $ProjectRoot "gui\$SolutionFile"
$ExePath      = Join-Path $ProjectRoot $ExeRelativePath
$PreBuildPath = Join-Path $ProjectRoot $PreBuildScript

if (-not (Test-Path $SolutionPath)) {
    Write-ErrorMsg "Solution not found: $SolutionPath"
    Write-Host "Expected repo structure: /gui/WinDurango.sln" -ForegroundColor Yellow
    Pop-Location
    exit 1
}

# ── CORE BUILD FUNCTIONS ───────────────────────────────────────────────────────
function Check-DotNet {
    Write-Info "Checking .NET 8 SDK..."
    $sdks = & dotnet --list-sdks 2>$null
    if (-not ($sdks -match '^8\.0')) {
        Write-ErrorMsg ".NET 8 SDK required."
        Write-Host "Download: https://dotnet.microsoft.com/download/dotnet/8.0" -ForegroundColor Yellow
        exit 1
    }
    Write-Success ".NET 8 SDK ready."
}

function Run-PreBuild {
    if (Test-Path $PreBuildPath) {
        Write-Info "Running pre-build script..."
        try {
            & $PreBuildPath
            if ($LASTEXITCODE -ne 0) { throw "Exit code $LASTEXITCODE" }
        } catch {
            Write-ErrorMsg "Pre-build failed: $_"
            exit $LASTEXITCODE
        }
    } else {
        Write-Warn "No pre-build script – skipping."
    }
}

function Restore-Packages {
    Write-Info "Restoring packages..."
    dotnet restore $SolutionPath --verbosity minimal
    if ($LASTEXITCODE -ne 0) { Write-ErrorMsg "Restore failed."; exit $LASTEXITCODE }
}

function Build-Solution {
    Write-Info "Building ($BuildConfig|$Platform)..."
    dotnet build $SolutionPath -c $BuildConfig --no-restore -p:Platform=$Platform --verbosity minimal
    if ($LASTEXITCODE -ne 0) { Write-ErrorMsg "Build failed."; exit $LASTEXITCODE }
    Write-Success "Build complete!"
}

function Launch-GUI {
    if (Test-Path $ExePath) {
        Write-Success "Launching WinDurango.UI..."
        $exeDir = Split-Path $ExePath -Parent
        Start-Process -FilePath $ExePath -WorkingDirectory $exeDir
    } else {
        Write-ErrorMsg "EXE not found: $ExePath"
        Write-Host "Build may have failed or path changed." -ForegroundColor Yellow
        exit 1
    }
}

# ── MAIN EXECUTION ─────────────────────────────────────────────────────────────
try {
    Check-DotNet
    Run-PreBuild
    Restore-Packages
    Build-Solution
    Launch-GUI
} finally {
    Pop-Location
}

Write-Host "`n=== Installation & Launch Complete ===" -ForegroundColor Magenta
Write-Host "Location: $ProjectRoot" -ForegroundColor Green
