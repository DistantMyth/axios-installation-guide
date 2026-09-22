# 04. Node Version Manager (`nvm`) Setup

Instead of installing the system package manager's Node.js package (which is often years out of date on Debian/Ubuntu and causes permissions issues), we use **NVM (Node Version Manager)**.

---

## 🌟 Why NVM on Linux?

1. **Avoids `sudo npm` Disasters**: If you install Node via `apt`, installing global CLI tools (`npm install -g yarn/typescript/pnpm`) requires `sudo`, which corrupts permissions in your home directory and introduces security risks. NVM installs Node inside `~/.nvm`, giving your user full permissions without ever needing `sudo`.
2. **Always Modern**: Debian and Ubuntu LTS releases often bundle obsolete Node versions (e.g. Node 18 or older). NVM allows you to install Node 20 or 22 LTS with a single command.
3. **Instant Switching**: Switch between project requirements with `nvm use 20` or `nvm use 22`.

---

## Step 1: Install NVM

Run the official NVM install script:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

The installer clones NVM to `~/.nvm` and automatically appends the necessary environment exports to your `~/.bashrc` (or `~/.zshrc`).

---

## Step 2: Reload Shell Configuration

Reload your terminal profile:

```bash
# If using Bash (default on Ubuntu/Debian/Fedora):
source ~/.bashrc

# If using Zsh (default on Manjaro/Kali):
source ~/.zshrc
```

Verify NVM is registered:
```bash
nvm --version
```
*(Outputs `0.40.1` or higher).*

---

## Step 3: Install Node.js LTS and Set as Default

1. Install the latest Long-Term Support (LTS) release of Node.js:
   ```bash
   nvm install --lts
   ```

2. Make this version your default for all new terminal sessions:
   ```bash
   nvm use --lts
   nvm alias default 'lts/*'
   ```

---

## Step 4: Quick Verification & Testing

Let's verify that Node.js and `npm` are working properly:

### 1. Verify Versions:
```bash
node -v
npm -v
```

### 2. Run a One-Line Interactive Test:
```bash
node -e 'console.log("🎉 Success: Node.js " + process.version + " is running via NVM on Linux!")'
```

### 3. (Optional) Spin up a Test Web Server:
Run this one-liner:
```bash
node -e "require('http').createServer((req, res) => res.end('Hello from Node on Linux!')).listen(3000, () => console.log('Server running at http://localhost:3000'));"
```
Open [http://localhost:3000](http://localhost:3000) in your browser. You will see `Hello from Node on Linux!`. Press `Ctrl + C` in your terminal to exit.

---

## 🛠️ Common NVM Commands

- `nvm ls`: List locally installed versions.
- `nvm ls-remote --lts`: List all available LTS versions available from Node.js.
- `nvm install 22`: Install specific Node version.
- `nvm use 22`: Switch to that version in the current terminal.

---

👉 **Next Step**: Proceed to **[05. Compilers & Shell PATH Configuration](./05-compilers-and-path.md)**.
