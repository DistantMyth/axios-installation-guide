# Linux Developer Setup Guide

Linux is the developer standard across tech companies, research institutions, high-performance computing, and server infrastructure. Developing directly on Linux provides unparalleled speed, native POSIX toolchains, and complete control over your environment.

Because different Linux distributions use different package managers, this guide categorizes commands according to the **three major Linux base families**:

| Base Family | Package Manager | Popular Distributions Based on It |
| :--- | :--- | :--- |
| **Debian / Ubuntu** | `apt` | Ubuntu, Linux Mint, Pop!_OS, Debian, Kali Linux, Zorin OS |
| **Arch Linux** | `pacman` | Arch Linux, Manjaro, EndeavourOS, Garuda Linux, ArcoLinux |
| **Fedora / Red Hat** | `dnf` | Fedora Workstation, RHEL, AlmaLinux, Rocky Linux |

---

## 🗺️ Linux Setup Roadmap

Follow these guides in numerical order:

| Step | Topic | Description | Link |
| :---: | :--- | :--- | :--- |
| **01** | **Package Managers & Repositories** | Enable repositories (`universe`), update package caches, and system upgrades | [01-package-managers.md](./01-package-managers.md) |
| **02** | **Core Packages Installation** | Install compilers (`gcc`/`g++`), build essentials, git, VS Code, and compression tools | [02-packages-installation.md](./02-packages-installation.md) |
| **03** | **`uv` Setup (Python)** | Install `uv`, navigate PEP 668 externally-managed environments, and fast virtualenvs | [03-uv-setup.md](./03-uv-setup.md) |
| **04** | **`nvm` Setup (Node.js)** | Install Node Version Manager (`nvm`), Node LTS, and run a quick verification test | [04-nvm-setup.md](./04-nvm-setup.md) |
| **05** | **Compilers & Shell PATH** | Configure `~/.bashrc` / `~/.zshrc`, add `~/.local/bin` to PATH, test `<bits/stdc++.h>` | [05-compilers-and-path.md](./05-compilers-and-path.md) |
| **06** | **Git & SSH Authentication** | Configure Git identity, generate Ed25519 SSH keys, copy via `wl-copy`/`xclip` | [06-git-setup.md](./06-git-setup.md) |
| **07** | **Java Setup** | Install OpenJDK 21 LTS, set `JAVA_HOME`, and verify single-file compiler execution | [07-java-setup.md](./07-java-setup.md) |
| **08** | **Docker Containers Setup** | Install Docker Engine, configure rootless user groups, and VS Code Dev Containers | [08-linux-container-setup.md](./08-linux-container-setup.md) |
| **09** | **Infosec Tools Setup** | Set up Nmap, Wireshark with non-root packet capture, Burp Suite, and security tools | [09-infosec-tools-setup.md](./09-infosec-tools-setup.md) |

---

## ⚡ Quick Verification Checklist

Open a new terminal window (`Ctrl + Alt + T`) and verify that all key utilities respond:

```bash
git --version
gcc --version
g++ --version
python3 --version
uv --version
nvm --version
node -v
npm -v
java -version
javac -version
docker --version
```

---

👉 **Let's begin**: Proceed to **[01. Package Managers & Repositories](./01-package-managers.md)**.
