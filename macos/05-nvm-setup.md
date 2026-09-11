# 05. Node Version Manager (`nvm`) Setup

Instead of using `brew install node` (which automatically updates to the bleeding-edge major release during `brew upgrade` and can break project dependencies), we use **NVM (Node Version Manager)**.

---

## 🌟 Why Use NVM on macOS?

1. **Avoid Version Breakages**: Homebrew's default `node` formula always targets the newest major release (e.g. Node 23), whereas industry and college projects typically require LTS versions (Node 20 or Node 22). NVM ensures your environment remains stable.
2. **Clean Global Installs**: Tools installed via `npm install -g` remain scoped to your active Node version without root permissions.
3. **One-Command Version Switching**: Switch between project requirements with `nvm use 20` or `nvm use 22`.

---

## Step 1: Install NVM

Run the official installation script in your Terminal:

```zsh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

---

## Step 2: Configure Your Zsh Shell

Ensure the NVM environment variables are loaded every time you open Terminal by checking `~/.zshrc`:

```zsh
if ! grep -q 'export NVM_DIR="$HOME/.nvm"' ~/.zshrc; then
  cat << 'EOF' >> ~/.zshrc

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
fi

source ~/.zshrc
```

Verify NVM is active:
```zsh
nvm --version
```
*(Outputs `0.40.1` or higher).*

---

## Step 3: Install Node.js LTS and Set as Default

1. Install the latest Long-Term Support (LTS) version of Node.js:
   ```zsh
   nvm install --lts
   ```

2. Make this version your default for all new terminal sessions:
   ```zsh
   nvm use --lts
   nvm alias default 'lts/*'
   ```

---

## Step 4: Quick Verification & Testing

Verify that Node.js and `npm` are functioning:

### 1. Check Versions:
```zsh
node -v
npm -v
```

### 2. Run a One-Line Interactive Test:
```zsh
node -e 'console.log("🎉 Success: Node.js " + process.version + " is running via NVM on macOS!")'
```

### 3. (Optional) Run a Test Web Server:
```zsh
node -e "require('http').createServer((req, res) => res.end('Hello from Node on Mac!')).listen(3000, () => console.log('Server running at http://localhost:3000'));"
```
Open [http://localhost:3000](http://localhost:3000) in Safari or Chrome. You will see `Hello from Node on Mac!`. Press `Ctrl + C` in Terminal to stop it.

---

👉 **Next Step**: Proceed to **[06. Git Setup & Authentication](./06-git-setup.md)**.
