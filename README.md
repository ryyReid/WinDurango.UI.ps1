# WinDurango.UI

**WinDurango.UI** is a modern Windows GUI for the **WinDurango compatibility layer**.  

With it you can:

- Install the compatibility layer into any MSIX/UWP package

- Manage mods and saves

- (Future) launch games, tweak settings, view logs, etc.

Built with **WinUI 3** + **.NET 8** -- works on **Windows 10 (19041+)** and **Windows 11**.

---

## Quick Start -- Fresh Windows Install

The `Install-WinDurango-Fresh.ps1` script **does everything for you**:

- Elevates to **Administrator**

- Checks & **installs .NET 8 SDK** if missing

- Warns about missing **Visual Studio workloads** (optional)

- Runs `BuildScripts\build.bat` if present

- Restores NuGet packages

- Builds the solution

- **Launches** `WinDurango.UI.exe`

### 1. Clone the repo

```powershell```

`git clone https://github.com/WinDurango/WinDurango.UI.git`

cd WinDurango.UI

2\. Run the installer

powershell

Copy code

`.\Install-WinDurango-Fresh.ps1`

Tip: Right-click the file → "Run with PowerShell" -- it will auto-relaunch as admin.

The GUI will appear automatically at:

text

Copy code

textbin\x64\Release\net8.0-windows10.0.26100.0\WinDurango.UI.exe

Requirements

Requirement  Details

OS  Windows 10 (build 19041+) or Windows 11

.NET 8 SDK  Automatically installed by the script if missing

Visual Studio 2022  Optional -- only needed for manual editing/building

Git  Needed only for cloning

License

MIT License -- see LICENSE for the full text.

Links

Repository -- WinDurango.UI GitHub

.NET 8 SDK -- Download .NET 8

## Enjoy Xbox-era games on modern Windows!
