# macOS Developer Setup Guide

macOS is a certified Unix-based operating system that provides a sleek, UNIX-compliant terminal environment and power efficiency on Apple Silicon (M1/M2/M3/M4) chips.

However, macOS differs in subtle ways from standard Linux—particularly with Apple Clang vs. GNU GCC, missing `<bits/stdc++.h>` header files, and Darwin-specific networking architectures that impact cybersecurity tools.

This guide provides a comprehensive setup tailored for both modern **Apple Silicon Macs (M1/M2/M3/M4)** and older **Intel Macs**.

---

## 🗺️ macOS Setup Roadmap

Follow these guides in numerical order:

| Step | Topic | Description | Link |
| :---: | :--- | :--- | :--- |
| **01** | **Homebrew Setup** | Install the Homebrew package manager and configure Apple Silicon PATH | [01-homebrew-setup.md](./01-homebrew-setup.md) |
| **02** | **Packages Installation** | Install command-line tools (`git`, `python`, `wget`, `7zip`) and VS Code cask | [02-packages-installation.md](./02-packages-installation.md) |
| **03** | **C++ Compilers Setup** | Install genuine GNU GCC, symlink binaries, and fix `<bits/stdc++.h>` | [03-compilers-setup.md](./03-compilers-setup.md) |
| **04** | **`uv` Setup (Python)** | Install Astral's fast Python project manager via Homebrew | [04-uv-setup.md](./04-uv-setup.md) |
| **05** | **`nvm` Setup (Node.js)** | Install Node Version Manager (`nvm`), Node LTS, and run a quick verification test | [05-nvm-setup.md](./05-nvm-setup.md) |
| **06** | **Git & SSH Authentication** | Configure Git identity, generate Ed25519 SSH keys, copy via `pbcopy` | [06-git-setup.md](./06-git-setup.md) |
| **07** | **Java Setup** | Install OpenJDK 21 LTS via Homebrew, symlink JVM, and configure `JAVA_HOME` | [07-java-setup.md](./07-java-setup.md) |
| **08** | **Linux Containers Setup** | Set up Docker Desktop / OrbStack / Colima on macOS | [08-linux-container-setup.md](./08-linux-container-setup.md) |
| **09** | **Infosec Tools Setup (Containers)** | Run cybersecurity tools inside isolated Linux containers on macOS | [09-infosec-tools-setup.md](./09-infosec-tools-setup.md) |

---

## ⚡ Automated Environment Verification (One-Liner)

You do **not** need to clone this repository or check tools manually. Simply open **Terminal** and run:

```bash
curl -fsSL https://raw.githubusercontent.com/DistantMyth/axios-installation-guide/main/verify.sh | bash
```

This runs our verification script directly from GitHub in memory, testing Homebrew, genuine GNU GCC vs Apple Clang, `<bits/stdc++.h>` compilation, Python 3, `uv`, `nvm`, Node LTS, Java, and Docker.

Alternatively, you can verify manually:

```zsh
brew --version
git --version
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

👉 **Let's begin**: Proceed to **[01. Homebrew Package Manager Setup](./01-homebrew-setup.md)**.
