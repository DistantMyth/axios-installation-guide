# 02. Core Packages & Toolchain Installation

Now we will install your C/C++ compilers, debugger, Git, Python 3, compression utilities, and Visual Studio Code.

Follow the section matching your Linux distribution:

---

## 1. Debian & Ubuntu-Based (`apt`)

Run the following commands in your terminal:

```bash
# 1. Install C/C++ compilers (gcc, g++, make, libc-dev) and GDB debugger:
sudo apt install -y build-essential gdb

# 2. Install Git, Python3, virtual environments, Curl, and Wget:
sudo apt install -y git python3 python3-pip python3-venv python-is-python3 curl wget

# 3. Install 7-Zip:
sudo apt install -y 7zip || sudo apt install -y p7zip-full
```

### Install Visual Studio Code on Ubuntu / Debian:

- **Via Snap (Ubuntu default):**
  ```bash
  sudo snap install --classic code
  ```
- **Via Official `.deb` (Recommended for Linux Mint & Debian where Snap is disabled):**
  ```bash
  # Download Microsoft GPG key and repo configuration:
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
  ```

---

## 2. Arch Linux & Derivatives (`pacman`)

Run the following commands:

```bash
# 1. Install development toolchain (gcc, g++, make) and GDB:
sudo pacman -S --needed base-devel gdb

# 2. Install Git, Python, 7-Zip, Curl, and Wget:
sudo pacman -S --needed git python python-pip curl wget 7zip

# 3. Install Visual Studio Code:
sudo pacman -S code
```
*(Note: `extra/code` is the open-source Code-OSS build. If you want the official Microsoft build with built-in Settings Sync and proprietary extension support, install `visual-studio-code-bin` using an AUR helper like `yay -S visual-studio-code-bin`).*

---

## 3. Fedora & Red Hat-Based (`dnf`)

Run the following commands:

```bash
# 1. Install C/C++ development tools and GDB:
sudo dnf install -y @development-tools gcc gcc-c++ gdb

# 2. Install Git, Python 3, Curl, Wget, and 7-Zip:
sudo dnf install -y git python3 python3-pip curl wget
sudo dnf install -y 7zip || sudo dnf install -y p7zip p7zip-plugins

# 3. Install Visual Studio Code via official Microsoft RPM repository:
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code
```

---

> [!NOTE]
> **Where are Node.js and `uv`?**
> - In **[03-uv-setup.md](./03-uv-setup.md)**, we set up `uv` to handle Python virtual environments cleanly without triggering PEP 668 system-protection errors.
> - In **[04-nvm-setup.md](./04-nvm-setup.md)**, we install **NVM** instead of distro Node.js packages to prevent permission conflicts with global npm installs.

---

👉 **Next Step**: Proceed to **[03. `uv` Setup (Python)](./03-uv-setup.md)**.
