# 04. Python Project & Package Manager (`uv`) Setup

**`uv`** (by Astral) is a fast, Rust-based Python package and project manager designed to replace `pip`, `pip-tools`, `virtualenv`, and `pyenv`. On macOS, it speeds up package installations by caching wheels and using copy-on-write filesystem clones on APFS (Apple File System).

---

## Step 1: Install `uv` via Homebrew

In Terminal, run:

```zsh
brew install uv
```

*(Alternatively, you can install it via the official standalone script: `curl -LsSf https://astral.sh/uv/install.sh | sh`)*.

---

## Step 2: Configure Zsh Auto-Completions (Optional but Recommended)

Add auto-completions to your `~/.zshrc`:

```zsh
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
source ~/.zshrc
```

Verify that `uv` is installed:
```zsh
uv --version
```
*(Outputs `uv 0.6.x` or newer).*

---

## ⚡ Daily Python Development Workflow with `uv`

Whenever starting a new assignment or coursework project:

### 1. Create a Project Directory & Virtual Environment:
```zsh
mkdir -p ~/projects/my-project && cd ~/projects/my-project
uv venv
```
*(Creates a clean `.venv` folder in under 30 milliseconds).*

### 2. Activate the Environment:
```zsh
source .venv/bin/activate
```

### 3. Install Machine Learning & Data Science Packages:
```zsh
uv pip install numpy pandas matplotlib scikit-learn jupyter
```
On Apple Silicon, `uv` automatically pulls Apple Silicon ARM64 pre-compiled wheels.

### 4. Run Scripts with Ephemeral Packages:
```zsh
uv run --with requests python -c "import requests; print('Status:', requests.get('https://api.github.com').status_code)"
```

---

👉 **Next Step**: Proceed to **[05. Node Version Manager (`nvm`) Setup](./05-nvm-setup.md)**.
