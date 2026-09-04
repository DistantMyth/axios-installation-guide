# 3. macOS Setup Guide

macOS is Unix-based and fantastic for development, but it has a few specific quirks—especially with C++ compilers and `<bits/stdc++.h>`. Follow these steps carefully.

---

## 📑 Table of Contents

- [3.1 Install Package Manager: Homebrew](#31-install-package-manager-homebrew)
- [3.2 Install Development Tools via Homebrew](#32-install-development-tools-via-homebrew)
- [3.3 Compilers: Clang vs GCC Problem & <bits/stdc++.h>](#33-compilers-the-mac-clang-vs-gcc-problem--bitsstdch)
  - [The Fix: Install Real GNU GCC via Homebrew](#the-fix-install-real-gnu-gcc-via-homebrew)
- [3.4 Git Setup & Authentication (macOS)](#34-git-setup--authentication-macos)
  - [Step 1: Set your Git Name and Email](#step-1-set-your-git-name-and-email)
  - [Step 2: Authenticate with GitHub via SSH](#step-2-authenticate-with-github-via-ssh)
- [Next Steps](#next-steps)

---

## 3.1 Install Package Manager: Homebrew
Homebrew (`brew`) is the essential package manager for macOS.

1. Open **Terminal** (Press `Cmd + Space`, type `Terminal`, and press Enter).
2. Copy and paste this command into your Terminal:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Type your Mac password when prompted (no stars or letters will show while typing passwords in Terminal; that is normal! Just type it and hit Enter).
4. Press Enter to confirm the installation.
5. **CRITICAL for Apple Silicon (M1, M2, M3, M4 Macs):**
   At the end of installation, Homebrew will display **Next steps** to add brew to your PATH. Run these two commands:
   ```bash
   (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```
   *(For older Intel Macs, brew is placed in `/usr/local/bin` and works automatically).*
6. Verify Homebrew:
   ```bash
   brew --version
   ```

---

## 3.2 Install Development Tools via Homebrew

Run the following command in Terminal to install all essential tools:

```bash
brew install git node python uv wget curl p7zip
brew install --cask visual-studio-code
```

> [!NOTE]
> *Alternative standalone install for uv:* If you prefer installing `uv` standalone directly:
> ```bash
> curl -LsSf https://astral.sh/uv/install.sh | sh
> ```

---

## 3.3 Compilers: The Mac Clang vs GCC Problem & `<bits/stdc++.h>`

> [!WARNING]
> **The Problem with Mac's Default C++ Compiler:**
> When you type `gcc` or `g++` on macOS, Apple automatically intercepts it and runs **Apple Clang** instead of genuine GNU GCC.
> Apple Clang **does NOT** include the header `<bits/stdc++.h>` which is universally used in competitive programming and Indian college curricula. If you try to compile code with `#include <bits/stdc++.h>`, you will get a frustrating error: `fatal error: 'bits/stdc++.h' file not found`.

### The Fix: Install Real GNU GCC via Homebrew

1. Install genuine GCC:
   ```bash
   brew install gcc
   ```
   *(This may take a couple of minutes to download and configure).*

2. Check which version of GCC was installed:
   ```bash
   brew list --versions gcc
   ```
   You will see something like `gcc 14.2.0` (meaning GCC version 14). Homebrew names the executables with their major version number, e.g., `gcc-14` and `g++-14`.

3. Configure your Mac so `gcc` and `g++` automatically point to GNU GCC:
   Run the following commands to create aliases in your `~/.zshrc` file:
   ```bash
   echo 'alias gcc="gcc-14"' >> ~/.zshrc
   echo 'alias g++="g++-14"' >> ~/.zshrc
   source ~/.zshrc
   ```
   *(Note: If your Homebrew installed version 13, replace `14` with `13`).*

4. Verify that `g++` is now genuine GCC:
   ```bash
   g++ --version
   ```
   It should say `g++-14 (Homebrew GCC ...)` instead of `Apple clang version ...`.

5. Test compiling a C++ file with `<bits/stdc++.h>`:
   ```bash
   echo '#include <bits/stdc++.h>
   int main() { std::cout << "Bits/stdc++.h works on Mac!" << std::endl; return 0; }' > test.cpp
   g++ test.cpp -o test && ./test
   ```
   If it prints `Bits/stdc++.h works on Mac!`, your compiler setup is perfect! You can delete the test file with `rm test test.cpp`.

---

## 3.4 Git Setup & Authentication (macOS)

### Step 1: Set your Git Name and Email
Open Terminal and run:
```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### Step 2: Authenticate with GitHub via SSH
1. Generate an SSH key:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. Press **Enter** to accept the default file, and press **Enter** twice for passphrase.
3. Copy your public key directly to your Mac clipboard:
   ```bash
   pbcopy < ~/.ssh/id_ed25519.pub
   ```
4. Go to **GitHub** in your browser:
   - Click your profile photo -> **Settings** -> **SSH and GPG keys**.
   - Click **New SSH key**.
   - Title: `My MacBook`.
   - Paste the key (`Cmd + V`) into the **Key** field.
   - Click **Add SSH key**.
5. Verify in Terminal:
   ```bash
   ssh -T git@github.com
   ```
   Type `yes` when prompted. You will see: `Hi <username>! You've successfully authenticated...`

macOS setup is complete!

---

## Next Steps

- Proceed to the **[5. Quick Verification Checklist](checklist.md)** to verify your setup.
- Or return to the **[Basic Installation Overview](README.md)**.
