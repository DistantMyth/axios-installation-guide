# 01. Chocolatey Package Manager Setup

**Chocolatey** (`choco`) is the standard machine package manager for Windows. It automates software installations, manages PATH variables, and ensures your developer tools stay updated from the command line.

---

## Step 1: Open Windows PowerShell as Administrator

1. Press the **Windows Key** on your keyboard and type **PowerShell**.
2. Look for **Windows PowerShell**, right-click it, and select **Run as administrator**.
   
   ![PowerShell Run as Administrator](../images/powershell-run-as-admin.png)

3. When prompted by the User Account Control (UAC) dialog asking *"Do you want to allow this app to make changes to your device?"*, click **Yes**.

---

## Step 2: Set Execution Policy & Install Chocolatey

PowerShell includes execution policies that restrict external scripts from running by default. We will set the execution policy to `RemoteSigned` for the current user and download Chocolatey.

Copy and paste the following single command into your Administrator PowerShell window, then press **Enter**:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

![Chocolatey Install Command Execution](../images/chocolatey-install-command.png)

> [!NOTE]
> Setting `-Scope CurrentUser` ensures your user account has permission to run virtual environment activation scripts (like Python `venv` or `uv`) and local npm binaries later without permission blocks.

Wait 30 to 60 seconds while Chocolatey downloads and registers itself in your system PATH.

---

## Step 3: Verify the Installation

1. Close the current PowerShell window.
2. Open a **new** PowerShell window (as Administrator).
3. Run:

```powershell
choco --version
```

![Chocolatey Version Check](../images/choco-version-check.png)

If PowerShell outputs a version number (such as `2.x.x`), Chocolatey is installed and ready to use!

---

## 🛠️ Troubleshooting

- **Command not recognized (`choco : The term 'choco' is not recognized`)**:
  - Close all open terminals and restart PowerShell. Environment variable changes only take effect in new terminal sessions.
  - If still unrecognized, run `$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")` to refresh PATH within the current session.
- **Corporate / School Proxy issues**:
  - If the script fails to download, ensure you are connected to an unrestricted Wi-Fi network (or mobile hotspot) rather than a restricted public proxy.

---

👉 **Next Step**: Proceed to **[02. Core Packages Installation](./02-packages-installation.md)**.
