# 03. Python Project & Package Manager (`uv`) Setup

On modern Linux systems, managing Python packages requires understanding **PEP 668** and why **`uv`** is the modern solution for developers.

---

## ⚠️ The Problem with Modern Linux & `pip` (PEP 668)

On modern distributions (Ubuntu 24.04+, Debian 12+, Fedora 40+, Arch), if you attempt to run:
```bash
pip install requests   # Or sudo pip install ...
```
You will receive this error:
```text
error: externally-managed-environment
× This environment is externally managed
╰─> To install Python packages system-wide, try 'apt install python3-xyz'...
```

**Why does this happen?** 
Linux system components (such as package managers, system daemons, and desktop components) are written in Python. In the past, running global `pip install` would overwrite system libraries and break your OS. Modern Linux distributions enforce PEP 668 to protect system stability.

---

## 🚀 The Solution: `uv` (Astral)

**`uv`** is a lightning-fast Python package and project manager written in Rust. It installs packages **10x to 100x faster than traditional pip**, manages virtual environments in milliseconds, installs Python versions on demand, and never corrupts your Linux system packages.

---

## Step 1: Install `uv`

### Universal Method (Recommended across all distros):
Run Astral's official standalone installer:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

*(This automatically installs `uv` to `~/.local/bin/uv` and configures your shell).*

### Distro Package Managers (Alternative):
- **Arch Linux**: `sudo pacman -S uv`
- **Fedora**: `sudo dnf install -y uv`

---

## Step 2: Ensure `~/.local/bin` is in Your PATH

Reload your shell configuration so the newly installed binary is available:

```bash
# If using Bash (Ubuntu/Debian/Fedora default):
source ~/.bashrc

# If using Zsh (Manjaro/Kali default):
source ~/.zshrc
```

Verify that `uv` is available:
```bash
uv --version
```
*(Should output `uv 0.6.x` or newer).*

---

## ⚡ Daily Python Workflow with `uv`

For any college project, assignment, or machine learning lab:

### 1. Create a Project Directory & Virtual Environment:
```bash
mkdir -p ~/projects/my-course-project && cd ~/projects/my-course-project
uv venv
```
*(Creates a clean, isolated `.venv` directory in ~30 milliseconds).*

### 2. Activate the Environment:
```bash
source .venv/bin/activate
```
*(Your terminal prompt will now show `(.venv)`).*

### 3. Install Packages:
```bash
uv pip install numpy pandas matplotlib requests scikit-learn
```

### 4. Running Scripts Directly:
You can also run standalone scripts without manual environment activation:
```bash
uv run python script.py
```

Or run scripts with temporary inline dependencies:
```bash
uv run --with requests python -c "import requests; print('Status:', requests.get('https://api.github.com').status_code)"
```

---

👉 **Next Step**: Proceed to **[04. Node Version Manager (`nvm`) Setup](./04-nvm-setup.md)**.
