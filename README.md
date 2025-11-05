# WinDurango.UI

**WinDurango.UI** is a modern Windows GUI for the **WinDurango compatibility layer**.  
With it you can:

* Install the compatibility layer into any MSIX/UWP package  
* Manage mods and saves  
* (Future) launch games, tweak settings, view logs, etc.

Built with **WinUI 3** + **.NET 8** – works on **Windows 10 (19041+)** and **Windows 11**.

---

## Quick Start – Fresh Windows Install

The `Install-WinDurango-Fresh.ps1` script **does everything for you**:

* Elevates to **Administrator**  
* Checks & **installs .NET 8 SDK** if missing  
* Warns about missing **Visual Studio workloads** (optional)  
* Runs `BuildScripts\build.bat` if present  
* Restores NuGet packages  
* Builds the solution  
* **Launches** `WinDurango.UI.exe`

### 1. Clone the repo

```powershell
git clone https://github.com/WinDurango/WinDurango.UI.git
cd WinDurango.UI
2. Run the installer
powershell
Copy code
powershell .\Install-WinDurango-Fresh.ps1
Tip: Right-click the file → “Run with PowerShell” – it will auto-relaunch as admin.

The GUI will appear automatically at:

sql
Copy code
textbin\x64\Release\net8.0-windows10.0.26100.0\WinDurango.UI.exe
Requirements
Requirement	Details
OS	Windows 10 (build 19041+) or Windows 11
.NET 8 SDK	Automatically installed by the script if missing
Visual Studio 2022	Optional – only needed for manual editing/building
Git	Needed only for cloning

License
MIT License – see LICENSE for the full text.

Links
Repository – https://github.com/WinDurango/WinDurango.UI

.NET 8 SDK – https://dotnet.microsoft.com/en-us/download/dotnet/8.0

Enjoy Xbox-era games on modern Windows!
Questions? Open an Issue or join our Discord (link in repo description).

What to do next
Save this as README.md in the repository root.

(Optional) Add a LICENSE file with the MIT text.

Commit & push – new users now have a single, fool-proof path to get running.

If you’d like an even more “one-click” experience (e.g., a downloadable .zip with a Run-Installer.ps1), you can bundle this later.

pgsql
Copy code

I cleaned up formatting, fixed code blocks, added tables for clarity, and ensured Markdown renders properly.  

I can also make a **slightly shorter, “GitHub ready” version** with badges and links that looks more professional if you want. Do you want me to do that?
