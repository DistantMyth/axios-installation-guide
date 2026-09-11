# 03. Python Project & Package Manager (`uv`) Setup

**`uv`** (built by Astral, the creators of Ruff) is an extremely fast, single-binary Python package and project manager written in Rust. It is **10x to 100x faster than traditional `pip`**, handles virtual environments effortlessly, resolves dependency conflicts deterministically, and can even install different Python versions automatically.

---

## ⚠️ Why We Use Winget Instead of Chocolatey

> [!WARNING]
> **Do NOT use `choco install uv`!**
> The community Chocolatey package for `uv` often fails with checksum mismatches, download timeouts, or PATH registration bugs on Windows.
> Instead, we install `uv` directly using Microsoft's native **Windows Package Manager (`winget`)**, which is built into Windows 10 (version 1809+) and Windows 11.

---

## Step 1: Install `uv` via Winget

Open **PowerShell** (administrator or regular user) and run:

```powershell
winget install --id=astral-sh.uv -e
```

*(You can also run `winget install uv` if you accept the source agreements).*

Press `Y` to accept license terms if prompted.

### Standalone Fallback (If `winget` is missing)
If you are on an older Windows 10 build that does not have `winget`, run Astral's official PowerShell installer:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

---

## Step 2: Verify Installation

Close your terminal and open a **new PowerShell window** so the updated PATH is loaded. Run:

```powershell
uv --version
```

You should see output similar to:
```text
uv 0.6.x (or latest)
```

---

## ⚡ How to Use `uv` for College Projects & Courses

Instead of relying on slow, error-prone global `pip install`, use `uv` for all Python coursework:

### 1. Create a Fast Virtual Environment
Navigate to any project folder in your terminal and run:
```powershell
uv venv
```
This creates a lightweight `.venv` folder in under 50 milliseconds!

### 2. Activate the Environment
```powershell
.venv\Scripts\Activate.ps1
```
*(If PowerShell shows a script execution error, run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` once).*

### 3. Install Packages at Blazing Speed
```powershell
uv pip install numpy pandas matplotlib requests
```
Packages will install and cache in seconds rather than minutes!

### 4. Run Scripts with Ephemeral Dependencies
You can even run single-file scripts without creating an environment:
```powershell
uv run --with requests python -c "import requests; print(requests.get('https://api.github.com').status_code)"
```

---

👉 **Next Step**: Proceed to **[04. Node Version Manager (`nvm`) Setup](./04-nvm-setup.md)**.
