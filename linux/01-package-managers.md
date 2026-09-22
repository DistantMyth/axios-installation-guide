# 01. Linux Package Managers & Repositories Setup

Before installing software, ensure your package manager is configured with the necessary repositories and has updated package metadata.

Find your distribution family below:

---

## Option A: Debian & Ubuntu-Based (`apt`)
*(Ubuntu, Linux Mint, Pop!_OS, Debian, Kali Linux, Zorin OS)*

### 1. Enable the Universe Repository (Ubuntu & Linux Mint)
Modern Ubuntu and Linux Mint desktop releases place developer tools—including `python3-pip`, `python3-venv`, and `7zip`—in the community-maintained **`universe`** repository. On minimal installations, `universe` is often disabled, leading to the dreaded error: `E: Unable to locate package ...`.

Run the following commands in your terminal (`Ctrl + Alt + T`):

```bash
# Install software-properties-common if not present
sudo apt update
sudo apt install -y software-properties-common

# Enable universe repository
sudo add-apt-repository universe -y

# Refresh package lists and upgrade existing software
sudo apt update && sudo apt upgrade -y
```

*(Note for pure Debian: Debian uses `main`, `contrib`, and `non-free` instead of `universe`. Simply run `sudo apt update && sudo apt upgrade -y`).*

---

## Option B: Arch Linux & Derivatives (`pacman`)
*(Arch Linux, Manjaro, EndeavourOS, Garuda Linux)*

Arch uses a rolling-release model where software packages are kept on the bleeding edge.

1. Synchronize repository databases and upgrade the entire system:
   ```bash
   sudo pacman -Syu
   ```

2. (Optional) If you are on standard Arch Linux, ensure the `multilib` repository is uncommented in `/etc/pacman.conf` if you need 32-bit library compatibility.

---

## Option C: Fedora & Red Hat-Based (`dnf`)
*(Fedora Workstation, RHEL, AlmaLinux, Rocky Linux)*

Fedora uses `dnf` (or `dnf5` on Fedora 41+).

1. Upgrade your system package database and core packages:
   ```bash
   sudo dnf upgrade -y
   ```

2. *(For RHEL, AlmaLinux, or Rocky Linux only)*: Enable the EPEL (Extra Packages for Enterprise Linux) repository:
   ```bash
   sudo dnf install -y epel-release
   ```

---

👉 **Next Step**: Proceed to **[02. Core Packages Installation](./02-packages-installation.md)**.
