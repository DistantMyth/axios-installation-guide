# Freshers & Juniors Basic Setup Guide

Welcome to college! This guide will help you set up your computer for programming, college coursework, competitive programming (CP), and web development from scratch.

> [!TIP]
> **How to use this guide:**
> 1. Complete the **Universal Section** first (Web accounts, Browser extensions, and VS Code extensions) — this applies to everyone regardless of operating system.
> 2. Jump to your specific Operating System section (**Windows**, **macOS**, or **Linux**) to install your tools, compilers, and configure Git.

---

# 1. Universal (Windows / macOS / Linux)

These steps are done directly in your web browser and code editor, so they are identical across all operating systems.

---

## 1.1 GitHub Account
GitHub is where developers store, share, and collaborate on code. Think of it as Google Drive or cloud storage, but built specifically for code.

- Visit [www.github.com](https://www.github.com).
- Click **Sign up** on the top right corner.
- ![Sign up on GitHub](Pasted%20image%2020260904030941.png)

- Enter your email address, create a strong password, and choose a professional username (avoid silly nicknames; you will put this on your resume!). You can also continue with Google or Apple.
  ![Enter details](Pasted%20image%2020260904031228.png)
- Complete the quick captcha puzzle and enter the 6-digit OTP code sent to your email. You should see this:
  ![Enter OTP](Pasted%20image%2020260904031555.png)
- Your GitHub account is now created! Keep your credentials safe.

---

## 1.2 Codeforces Account
Codeforces is one of the most popular platforms in the world for competitive programming and coding contests.

- Visit [https://codeforces.com/](https://codeforces.com/).
- Click **Register** on the top right corner.
  ![Codeforces Register](Pasted%20image%2020260904044811.png)
- Choose a professional handle (username), enter your email address, and create a secure password (you can also register using your Gmail account).
  ![Codeforces Details](Pasted%20image%2020260904045015.png)
- Check your email inbox. You will receive an email with a verification link — click that link to activate your account.
- Your Codeforces account is ready!

---

## 1.3 CodeChef Account
CodeChef is an Indian competitive programming platform widely used for monthly contests, learning data structures, and college hackathons.

- Visit [https://www.codechef.com/](https://www.codechef.com/).
- Click the **New User / Register** button in the top right corner.
  ![[Screenshot: CodeChef Homepage and Register Button]]

- You can sign up using your **Google Account** / **GitHub Account**, or enter your email manually:
  ![[Screenshot: CodeChef Sign Up Form]]
  - Enter your Email.
  - Choose a unique Username/Handle.
  - Set a strong Password.

- Fill in your basic student details:
  - Country: **India**
  - Current Institution / College Name: Search and select your college.
  - Graduation Year: Select your expected graduation year.
  - User Type: **Student**
  ![[Screenshot: CodeChef Student Profile Details]]

- Click **Create Account**. If an email verification link is sent, open your inbox and click the verification link.
- Your CodeChef account is now active!

---

## 1.4 Recommended Browser Extensions
Install these browser extensions (available on Chrome Web Store, Firefox Add-ons, and Microsoft Edge Add-ons) to make your coding and contest experience 10x smoother:

### For Competitive Programming (Codeforces / CodeChef):
1. **Competitive Companion**:
   - Parses problem test cases directly from Codeforces, CodeChef, AtCoder, etc., into your VS Code editor with a single click.
   - [Chrome Web Store Link](https://chromewebstore.google.com/detail/competitive-companion/cjnmckjndlpiamollfdakhflhaehbmcng)
   - ![[Screenshot: Competitive Companion Extension in Web Store]]

2. **Carrot**:
   - Calculates predicted rating changes in real-time during live Codeforces contests.
   - [Chrome Web Store Link](https://chromewebstore.google.com/detail/carrot/gniknkfdngackbijbbkchcmegicnjond)
   - ![[Screenshot: Carrot Extension Codeforces]]

3. **Codeforces Enhancer**:
   - Cleans up the Codeforces UI, adds multiple rating color highlights, and auto-hides solved problems.

### For Web Development:
1. **JSON Viewer / JSON Formatter**:
   - Makes API responses and JSON files clean, colorful, and readable in the browser instead of raw unreadable text.
2. **React Developer Tools** *(optional for later)*:
   - Inspects React component hierarchies in the browser's developer tools.

---

## 1.5 Essential VS Code Extensions
Once you install VS Code (from your OS section below), open VS Code, click the **Extensions** icon on the left sidebar (shortcut: `Ctrl + Shift + X` on Windows/Linux, `Cmd + Shift + X` on Mac), search for the following extensions, and click **Install**:

![[Screenshot: VS Code Extensions Tab]]

### C / C++ & Competitive Programming:
- **C/C++** (by Microsoft): Syntax highlighting, code completion (IntelliSense), and debugging.
- **C/C++ Extension Pack** (by Microsoft): Includes tools and CMake support.
- **Competitive Programming Helper (cph)** (by Divyanshu Agrawal):
  - Essential for CP! Works with the *Competitive Companion* browser extension to auto-fetch test cases and run them against your code in one click.
  - ![[Screenshot: CPH extension in VS Code]]

### Python:
- **Python** (by Microsoft): Linting, debugging, code formatting.
- **Pylance** (by Microsoft): Super-fast autocomplete and type checking for Python.

### Web Development:
- **Live Server** (by Ritwick Dey): Launch a local development server with live reload for HTML/CSS/JavaScript.
- **Prettier - Code Formatter**: Automatically cleans up and formats your code nicely whenever you save.
- **Auto Rename Tag**: Automatically renames paired HTML/XML tags.
- **Tailwind CSS IntelliSense**: Autocomplete and preview for Tailwind CSS classes.

### Quality of Life & Themes:
- **Error Lens**: Highlights syntax errors and warnings inline directly on your code lines so you spot bugs instantly.
- **Material Icon Theme**: Makes your file and folder icons beautiful and easy to distinguish.

---

# 2. Windows Setup Guide

For Windows, we will use **Chocolatey**, the most popular package manager for Windows. Instead of manually downloading 10 different `.exe` installers from random websites and clicking "Next-Next-Finish", Chocolatey installs everything safely via a single command!

---

## 2.1 Install Package Manager: Chocolatey

1. Press the **Windows Key** on your keyboard, type **PowerShell**.
2. **Right-click** on **Windows PowerShell** and select **Run as Administrator**.
   ![[Screenshot: Windows PowerShell Run as Administrator]]
3. Click **Yes** on the User Account Control (UAC) prompt.
4. Copy and paste the following command into PowerShell and press **Enter**:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```
   ![[Screenshot: Chocolatey Installation Output in PowerShell]]
5. Wait 30–60 seconds until the installation finishes.
6. Close the PowerShell window, then open a fresh PowerShell window (as Administrator) and verify it works by typing:
   ```powershell
   choco --version
   ```
   If it prints a version number (like `2.x.x`), Chocolatey is ready!

> [!NOTE]
> *Alternative*: Modern Windows 11/10 also comes with a built-in package manager called `winget`. However, Chocolatey is recommended here as it reliably configures developer PATH variables.

---

## 2.2 Install All Development Tools (One-Click)

Open **PowerShell as Administrator** and run this single command to install everything you need:

```powershell
choco install -y git vscode nodejs-lts python3 7zip curl wget mingw
```

What this installs:
- `git`: Version control system.
- `vscode`: Visual Studio Code editor.
- `nodejs-lts`: Node.js (Long Term Support) & `npm` for web development.
- `python3`: Python programming language & `pip`.
- `7zip`: Compression & extraction tool.
- `curl` & `wget`: Command-line tools for downloading files and testing APIs.
- `mingw`: MinGW-w64 (includes `gcc`, `g++`, and `gdb` compilers for C and C++).

![[Screenshot: Chocolatey Batch Installation in Progress]]

---

## 2.3 Compilers & Environment Variables (PATH)

### What is the PATH Environment Variable?
Think of your computer as a giant library. When you type `gcc` or `python` in a terminal, Windows doesn't know where those programs are stored unless you add their folder location to the **PATH**. PATH is a list of directory shortcuts that Windows checks whenever you run a command.

Chocolatey automatically sets up most paths, but you must verify that the C/C++ compiler (`gcc`/`g++`) is registered.

### Step-by-Step PATH Verification:
1. Press `Windows Key + R`, type `sysdm.cpl`, and hit **Enter** (or search **Edit the system environment variables** in the Start Menu).
   ![[Screenshot: System Properties Window]]
2. In the System Properties window, click on the **Advanced** tab, then click the **Environment Variables...** button at the bottom.
   ![[Screenshot: Advanced Tab Environment Variables Button]]
3. In the lower section called **System variables**, find the variable named **Path** and click **Edit...**.
   ![[Screenshot: Edit Environment Variable Window]]
4. Check if the MinGW bin path exists in the list (usually `C:\tools\mingw64\bin` or `C:\ProgramData\chocolatey\bin`).
   - If it is **not** there:
     - Click **New**.
     - Paste: `C:\tools\mingw64\bin` (or the folder where MinGW's `gcc.exe` was installed).
     - Click **OK** on all windows to save.
5. **Restart your terminal / PowerShell** (environment variables only update in newly opened terminals).

### Verify Everything in a New Terminal:
Open a regular PowerShell or Command Prompt window and run:

```powershell
gcc --version
g++ --version
python --version
node --version
git --version
```

![[Screenshot: Successful Version Verification on Windows Terminal]]

If all of them return version numbers, your Windows development environment is completely set up!

---

## 2.4 Git Setup & Authentication (Windows)

Now we will configure your identity in Git and link your computer to your GitHub account.

### Step 1: Set your Git Name and Email
Open PowerShell and run:
```powershell
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```
*(Make sure to use the exact same email address you used when registering on GitHub!)*

### Step 2: Authenticate with GitHub (SSH Key Method)
1. In PowerShell, generate a new secure SSH key:
   ```powershell
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. Press **Enter** to accept the default file location.
3. Press **Enter** twice when asked for a passphrase (or enter a passphrase if you want extra security).
   ![[Screenshot: SSH Key Generation Output Windows]]
4. Copy your public key to the clipboard:
   ```powershell
   Get-Content ~/.ssh/id_ed25519.pub | Set-Clipboard
   ```
5. Go to GitHub:
   - Click your profile photo in the top right -> **Settings**.
   - On the left sidebar, click **SSH and GPG keys**.
   - Click the green **New SSH key** button.
   - Set Title: `My Windows Laptop`.
   - Key type: `Authentication Key`.
   - Paste your key into the **Key** box.
   - Click **Add SSH key**.
   ![[Screenshot: Adding SSH Key on GitHub Settings]]
6. Test your connection in PowerShell:
   ```powershell
   ssh -T git@github.com
   ```
   If prompted *"Are you sure you want to continue connecting (yes/no/[fingerprint])?"*, type `yes` and hit Enter.
   You will see: `Hi <username>! You've successfully authenticated...`

Git is now 100% installed, configured, and authenticated on your Windows PC!

---

# 3. macOS Setup Guide

macOS is Unix-based and fantastic for development, but it has a few specific quirks—especially with C++ compilers and `<bits/stdc++.h>`. Follow these steps carefully.

---

## 3.1 Install Package Manager: Homebrew
Homebrew (`brew`) is the essential package manager for macOS.

1. Open **Terminal** (Press `Cmd + Space`, type `Terminal`, and press Enter).
   ![[Screenshot: Opening Terminal on Mac]]
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
brew install git node python wget curl p7zip
brew install --cask visual-studio-code
```

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
   ![[Screenshot: brew install gcc in Mac Terminal]]

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
   ![[Screenshot: Adding SSH Key on GitHub from Mac]]
5. Verify in Terminal:
   ```bash
   ssh -T git@github.com
   ```
   Type `yes` when prompted. You will see: `Hi <username>! You've successfully authenticated...`

macOS setup is complete!

---

# 4. Linux Setup Guide

Linux is the developer standard in industry and academia. There are dozens of Linux distributions, but almost all of them belong to one of three major **base families**.

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

4. Install Node.js and npm:
   ```bash
   sudo apt install -y nodejs npm
   ```
   *(Or install the latest LTS version using NodeSource).*

5. Install Visual Studio Code:
   ```bash
   sudo snap install --classic code
   ```
   *Alternative without snap:* Download the official `.deb` package from [code.visualstudio.com](https://code.visualstudio.com/) and run `sudo dpkg -i <filename>.deb`.

![[Screenshot: Ubuntu Terminal Installation Commands]]

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

3. Install Git, Python, Curl, Wget, and 7-Zip:
   ```bash
   sudo pacman -S git python python-pip curl wget p7zip
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

![[Screenshot: Arch Linux Terminal Pacman Commands]]

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

3. Install Git, Python, Curl, Wget, and 7-Zip:
   ```bash
   sudo dnf install -y git python3 python3-pip curl wget p7zip p7zip-plugins
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

![[Screenshot: Fedora Terminal DNF Commands]]

---

## 4.3 Environment Variables & PATH on Linux

On Linux, your user environment variables and search paths are stored in shell configuration files:
- If you use Bash (default on Ubuntu, Fedora, Debian): `~/.bashrc`
- If you use Zsh (default on Manjaro, Kali, macOS): `~/.zshrc`

### How Environment Variables Work:
Whenever you install tools manually or through custom scripts (like Python local packages or `nvm`), they might install binaries to `~/.local/bin` or custom directories.

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
   ![[Screenshot: GitHub SSH Key Addition Linux]]
7. Verify in Terminal:
   ```bash
   ssh -T git@github.com
   ```
   Type `yes` when prompted. You will see:
   `Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.`

---

# 5. Quick Verification Checklist

Before starting your college lab or contest, run this quick checklist:

- [ ] GitHub account created & SSH key added
- [ ] Codeforces account created & verified
- [ ] CodeChef account created & verified
- [ ] VS Code installed with C/C++, CPH, and Python extensions
- [ ] C++ compiler working with test file (`#include <bits/stdc++.h>`)
- [ ] Python, Node.js, Git, Curl, 7-Zip, Wget responding in terminal
- [ ] Competitive Companion browser extension installed
