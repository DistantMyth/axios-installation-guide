# Windows Developer Setup Guide

This guide provides a streamlined, battle-tested setup path for Windows 10 and Windows 11 machines.

Instead of hunting for `.exe` installers across dozens of random websites and manually clicking through wizard installers, we use Windows package managers (**Chocolatey** and **Winget**) to install, configure, and maintain your toolchain reliably.

---

## 🗺️ Windows Setup Roadmap

Follow these guides in numerical order:

| Step | Topic | Description | Link |
| :---: | :--- | :--- | :--- |
| **01** | **Chocolatey Setup** | Install the Chocolatey package manager in Administrator PowerShell | [01-chocolatey-setup.md](./01-chocolatey-setup.md) |
| **02** | **Packages Installation** | Install core development packages (`git`, `vscode`, `python3`, `mingw`, `7zip`, `wget`) | [02-packages-installation.md](./02-packages-installation.md) |
| **03** | **`uv` Setup (Winget)** | Install the modern Python project manager via `winget` (fixes broken choco install) | [03-uv-setup.md](./03-uv-setup.md) |
| **04** | **`nvm` Setup (Node.js)** | Install Node Version Manager (`nvm-windows`), Node LTS, and run a quick verification test | [04-nvm-setup.md](./04-nvm-setup.md) |
| **05** | **Compilers & PATH** | Disable Windows App Execution Aliases, verify MinGW C/C++ in PATH | [05-compilers-and-path.md](./05-compilers-and-path.md) |
| **06** | **Git & SSH Authentication** | Configure Git username/email, generate Ed25519 SSH keys, connect to GitHub | [06-git-setup.md](./06-git-setup.md) |
| **07** | **Java Setup** | Install OpenJDK 21 LTS, set `JAVA_HOME` & PATH, verify with compiler test | [07-java-setup.md](./07-java-setup.md) |
| **08** | **WSL2 & Linux Containers** | Install Ubuntu on WSL2, set up Docker Desktop backend, and VS Code WSL | [08-wsl-setup.md](./08-wsl-setup.md) |
| **09** | **Infosec Tools Setup** | Configure Nmap, Wireshark, Burp Suite, and pentest tools inside WSL2 & Windows | [09-infosec-tools-setup.md](./09-infosec-tools-setup.md) |

---

## ⚡ Quick Verification Checklist

After completing all chapters, opening a new PowerShell window and running the following commands should all succeed without errors:

```powershell
choco --version
git --version
code --version
gcc --version
g++ --version
python --version
uv --version
nvm version
node -v
npm -v
java -version
javac -version
wsl --status
```

---

👉 **Let's begin**: Proceed to **[01. Chocolatey Setup](./01-chocolatey-setup.md)**.
