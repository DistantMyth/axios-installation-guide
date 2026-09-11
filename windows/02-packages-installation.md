# 02. Core Packages Installation via Chocolatey

With Chocolatey installed, we can batch-install all core development packages in a single step rather than manually downloading dozens of standalone setup files.

---

## Batch Installation Command

Open **PowerShell as Administrator** and execute the following command:

```powershell
choco install -y git vscode python3 7zip wget mingw
```

![Chocolatey Batch Install Progress 1](../images/choco-install-tools-1.png)
![Chocolatey Batch Install Progress 2](../images/choco-install-tools-2.png)
![Chocolatey Batch Install Progress 3](../images/choco-install-tools-3.png)

---

## 📦 What Was Installed

| Package Name | Utility / Description |
| :--- | :--- |
| `git` | Distributed version control system for tracking code changes and syncing with GitHub. |
| `vscode` | Visual Studio Code, our primary code editor. |
| `python3` | The Python programming language runtime and standard `pip` package manager. |
| `mingw` | MinGW-w64 toolchain providing genuine GNU C and C++ compilers (`gcc`, `g++`, `gdb`). |
| `7zip` | High-performance archive compression and extraction utility. |
| `wget` | Command-line file downloader for terminal scripts. |

---

## ⚠️ Important Notes on Node.js and `uv`

1. **Why is `nodejs-lts` omitted from this command?**
   Installing Node.js globally via package managers can lead to permission issues when installing global npm packages and locks you into a single version. In **[04-nvm-setup.md](./04-nvm-setup.md)**, we will install **NVM (Node Version Manager)** instead, which allows switching between Node versions smoothly without administrative permission headaches.
2. **Why is `uv` omitted from this command?**
   Chocolatey's community package for `uv` frequently fails or hangs during installation. In **[03-uv-setup.md](./03-uv-setup.md)**, we use Microsoft's official **Winget** package manager to install `uv` reliably in seconds.

---

## Quick Session PATH Reload

After the installation finishes, reload your environment variables into the current session by running:

```powershell
refreshenv
```
*(Or simply close and reopen your PowerShell window).*

---

👉 **Next Step**: Proceed to **[03. `uv` Setup via Winget](./03-uv-setup.md)**.
