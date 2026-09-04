# 4. Linux Setup Guide

Linux is the developer standard in industry and academia. There are dozens of Linux distributions, but almost all of them belong to one of three major **base families**.

---

## 📑 Table of Contents

- [4.1 Popular Linux Distros and Their Base Families](#41-popular-linux-distros-and-their-base-families)
- [4.2 Installation by Distro Base](#42-installation-by-distro-base)
  - [Option A: Debian / Ubuntu-based (`apt`)](#option-a-debian--ubuntu-based-apt)
  - [Option B: Arch Linux-based (`pacman`)](#option-b-arch-linux-based-pacman)
  - [Option C: Fedora / Red Hat-based (`dnf`)](#option-c-fedora--red-hat-based-dnf)
- [4.3 Environment Variables & PATH on Linux](#43-environment-variables--path-on-linux)
  - [How Environment Variables Work](#how-environment-variables-work)
  - [Verify All Tools on Linux](#verify-all-tools-on-linux)
- [4.4 Git Setup & Authentication (Linux)](#44-git-setup--authentication-linux)
  - [Step 1: Set your Git Name and Email](#step-1-set-your-git-name-and-email)
  - [Step 2: Authenticate with GitHub via SSH](#step-2-authenticate-with-github-via-ssh)
- [Next Steps](#next-steps)

---

## 4.1 Popular Linux Distros and Their Base Families

Find your distribution in the table below to know which package manager section to follow:

| Base Family | Package Manager | Popular Distributions Based on It |
| :--- | :--- | :--- |
| **Debian / Ubuntu** | `apt` | Ubuntu, Linux Mint, Pop!_OS, Debian, Kali Linux, Zorin OS, Elementary OS |
| **Arch Linux** | `pacman` | Arch Linux, Manjaro, EndeavourOS, Garuda Linux, ArcoLinux |
| **Fedora / Red Hat** | `dnf` | Fedora Workstation, Red Hat Enterprise Linux (RHEL), AlmaLinux, Rocky Linux, CentOS Stream |

---

## 4.2 Installation by Distro Base

Open your terminal (`Ctrl + Alt + T` on most distros) and run the commands for your family.

---

### Option A: Debian / Ubuntu-based (`apt`)
*(Ubuntu, Linux Mint, Pop!_OS, Debian, Kali, Zorin)*

1. Update package lists:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. Install compilers, build essentials, and debugger:
   ```bash
   sudo apt install -y build-essential gdb
   ```
   *(This installs `gcc`, `g++`, `make`, and standard C/C++ libraries).*

3. Install Git, Python, Curl, Wget, and 7-Zip:
   ```bash
   sudo apt install -y git python3 python3-pip python3-venv curl wget p7zip-full
   ```

4. Install uv (modern, blazing-fast Python package & project manager):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```
   *(uv installs to `~/.local/bin/uv` which is covered in the PATH section below).*

5. Install Node.js and npm:
   ```bash
   sudo apt install -y nodejs npm
   ```
   *(Or install the latest LTS version using NodeSource).*

6. Install Visual Studio Code:
   ```bash
   sudo snap install --classic code
   ```
   *Alternative without snap:* Download the official `.deb` package from [code.visualstudio.com](https://code.visualstudio.com/) and run `sudo dpkg -i <filename>.deb`.

---

### Option B: Arch Linux-based (`pacman`)
*(Arch, Manjaro, EndeavourOS, Garuda)*

1. Update system databases:
   ```bash
   sudo pacman -Syu
   ```

2. Install compilers, development tools, and debugger:
   ```bash
   sudo pacman -S --needed base-devel gdb
   ```

3. Install Git, Python, uv, Curl, Wget, and 7-Zip:
   ```bash
   sudo pacman -S git python python-pip uv curl wget p7zip
   ```

4. Install Node.js and npm:
   ```bash
   sudo pacman -S nodejs npm
   ```

5. Install Visual Studio Code:
   ```bash
   sudo pacman -S code
   ```
   *(Or `visual-studio-code-bin` via your AUR helper like `yay -S visual-studio-code-bin` for official Microsoft branding).*

---

### Option C: Fedora / Red Hat-based (`dnf`)
*(Fedora, RHEL, AlmaLinux, Rocky Linux)*

1. Update your system:
   ```bash
   sudo dnf upgrade -y
   ```

2. Install development tools and C/C++ compilers:
   ```bash
   sudo dnf groupinstall -y "Development Tools"
   sudo dnf install -y gcc gcc-c++ gdb
   ```

3. Install Git, Python, uv, Curl, Wget, and 7-Zip:
   ```bash
   sudo dnf install -y git python3 python3-pip uv curl wget p7zip p7zip-plugins
   ```

4. Install Node.js and npm:
   ```bash
   sudo dnf install -y nodejs npm
   ```

5. Install Visual Studio Code:
   Import the Microsoft repository and install:
   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
   sudo dnf check-update
   sudo dnf install -y code
   ```

---

## 4.3 Environment Variables & PATH on Linux

On Linux, your user environment variables and search paths are stored in shell configuration files:
- If you use Bash (default on Ubuntu, Fedora, Debian): `~/.bashrc`
- If you use Zsh (default on Manjaro, Kali, macOS): `~/.zshrc`

### How Environment Variables Work:
Whenever you install tools manually or through custom scripts (like Python local packages, `uv`, or `nvm`), they might install binaries to `~/.local/bin` or custom directories.

To add any custom directory to your PATH:
1. Open `~/.bashrc` (or `~/.zshrc`) in an editor:
   ```bash
   nano ~/.bashrc
   ```
2. Scroll to the very bottom and add:
   ```bash
   export PATH="$HOME/.local/bin:$PATH"
   ```
3. Press `Ctrl + O` then `Enter` to save, and `Ctrl + X` to exit.
4. Reload the file without restarting:
   ```bash
   source ~/.bashrc
   ```

### Verify All Tools on Linux:
```bash
gcc --version
g++ --version
python3 --version
uv --version
node --version
git --version
```
All should output valid version numbers.

---

## 4.4 Git Setup & Authentication (Linux)

### Step 1: Set your Git Name and Email
```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### Step 2: Authenticate with GitHub via SSH
1. Generate an SSH key:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. Press **Enter** to accept the default file location, and press **Enter** twice for passphrase.
3. Display and copy your public SSH key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   Select the printed text (`ssh-ed25519 AAAAC3... your_email@example.com`) and copy it (`Ctrl + Shift + C` in Linux terminal).
   *(Optional: install `xclip` via `sudo apt install xclip` or `sudo pacman -S xclip` and run `xclip -selection clipboard < ~/.ssh/id_ed25519.pub`)*.
4. Go to **GitHub** -> **Settings** -> **SSH and GPG keys** -> **New SSH key**.
5. Title: `My Linux Machine`.
6. Paste the key and click **Add SSH key**.
7. Verify in Terminal:
   ```bash
   ssh -T git@github.com
   ```
   Type `yes` when prompted. You will see:
   `Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.`

---

## Next Steps

- Now that VS Code, build tools, and Git are installed, head over to **[1.5 Essential VS Code Extensions](universal.md#15-essential-vs-code-extensions)** to install the recommended extensions (C/C++, CPH, Code Runner, Python, etc.).
- After installing extensions, proceed to the **[5. Quick Verification Checklist](checklist.md)** to verify your complete setup.
- Or return to the **[Basic Installation Overview](README.md)**.
