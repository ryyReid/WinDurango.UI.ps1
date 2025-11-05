# WinDurango.UI

**WinDurango.UI** is the user interface component for the **WinDurango** project, an experimental, open-source emulator targeting the Xbox platform (codenamed "Durango" for Xbox One).

This repository contains the front-end application and build automation scripts to quickly set up, compile, and launch the emulator on a fresh Windows system.

---

## 🚀 Quick Start (Automated Setup)

The recommended way to build and run the project is by using the included **`Install-WinDurango-Fresh.ps1`** PowerShell script. This script handles all prerequisites, building, and launching in a single, automated workflow.

### Prerequisites

* **Windows 10/11**
* **PowerShell 5.1+**
* **Git** (for cloning this repository)

### Usage

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/WinDurango/WinDurango.UI.git](https://github.com/WinDurango/WinDurango.UI.git)
    cd WinDurango.UI
    ```

2.  **Run the Installer Script:**
    Locate the `Install-WinDurango-Fresh.ps1` file, **right-click** it, and select **Run with PowerShell**.

    Alternatively, run from the command line:
    ```powershell
    .\Install-WinDurango-Fresh.ps1
    ```
    The script will automatically re-launch itself with **Administrator privileges** if required.

### What the Script Does

The script is designed for a completely fresh environment and performs the following actions:

| Step | Action | Dependency/Tool |
| :--- | :--- | :--- |
| **1. Elevation** | Checks for Administrator rights and automatically relaunches itself using `RunAs` if necessary. | `Ensure-Admin` |
| **2. .NET SDK Check** | Verifies the presence of the **.NET 8 SDK**. If missing, it offers to download and perform a silent installation. | `Install-DotNetSDK` |
| **3. VS Workload Check** | Scans for required Visual Studio workloads (`ManagedDesktop`, `NativeDesktop`) and issues a warning if they are not installed. | `vswhere` |
| **4. Pre-build** | Executes the optional `BuildScripts\build.bat` file if it exists. | `Run-PreBuild` |
| **5. Restore** | Restores all project dependencies (NuGet packages). | `dotnet restore` |
| **6. Build** | Compiles the solution in the configured **Release \| x64** mode. | `dotnet build` |
| **7. Launch** | Starts the final executable: `WinDurango.UI.exe`. | `Start-Process` |

---

## 🛠️ Manual Build Details

For manual building or troubleshooting, here are the key project details:

### Requirements

* **Visual Studio 2022**
* **.NET 8 SDK**
* Required Visual Studio Workloads:
    * `.NET desktop development`
    * `Desktop development with C++`

### Build Output Path

The script targets the following output path for the built executable:

`WinDurango.sln` directory
└── `bin`
    └── `x64`
        └── `Release`
            └── `net8.0-windows10.0.26100.0`
                └── **`WinDurango.UI.exe`**

The default, full path based on the script's configuration is:
`C:\Users\Reid am\Documents\xbox Emu\gui\bin\x64\Release\net8.0-windows10.0.26100.0\WinDurango.UI.exe`

---

## 🤝 Contributing

WinDurango is an ambitious open-source project, and contributions are welcome. If you are skilled in **C++** and **Windows Internals**, please check the main WinDurango repository or join the project's Discord channel for discussion on development tasks.

* **License:** GNU General Public License, version 3 (GPL-3.0).

