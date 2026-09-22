# 01. Homebrew Package Manager Setup

**Homebrew** (`brew`) is the de facto package manager for macOS. It installs open-source developer command-line utilities, compilers, libraries, and GUI applications cleanly into their own isolated directories.

---

## Step 1: Open the Terminal

1. Press `Cmd + Space` to launch Spotlight.
2. Type `Terminal` and press **Enter**.

---

## Step 2: Run the Official Homebrew Installer

Copy and paste this command into your Terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

1. Enter your Mac's login password when prompted.
   *(Note: For security, macOS Terminal will not display asterisks, dots, or characters while you type your password. Simply type your password and press **Enter**).*
2. Press **Enter** to confirm the installation paths.
3. The installer will download and install the Xcode Command Line Tools automatically if they are not already present.

---

## Step 3: CRITICAL Step for Apple Silicon (M1 / M2 / M3 / M4 Macs)

> [!IMPORTANT]
> **Apple Silicon vs. Intel Macs:**
> - On **Apple Silicon Macs**, Homebrew installs its binaries to `/opt/homebrew/bin` to prevent conflicts with Rosetta 2 x86 emulation.
> - On **Intel Macs**, Homebrew installs to `/usr/local/bin` and is linked automatically.
>
> If you are using an Apple Silicon Mac, you **MUST** add Homebrew to your PATH. At the end of the installation, run the following two commands:

```zsh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## Step 4: Verify Installation

Check that Homebrew is working:

```zsh
brew --version
```

Output should display `Homebrew 4.x.x`.

Optionally run a health check:
```zsh
brew doctor
```
*(If it outputs `Your system is ready to brew.`, your setup is in perfect health!)*

---

👉 **Next Step**: Proceed to **[02. Core Packages Installation](./02-packages-installation.md)**.
