# 04. Node Version Manager (`nvm`) Setup

Instead of installing a single static version of `nodejs-lts`, we install **NVM (Node Version Manager)**. 

---

## 🌟 Why Use NVM Instead of a Direct Node.js Installer?

1. **Effortless Version Switching**: Different projects or college assignments often require specific Node versions (e.g., Node 18, 20, or 22). With NVM, switching takes one command: `nvm use 20`.
2. **Eliminate Permission Errors**: Direct Node installations often trigger `EACCES` or administrator permission errors when running `npm install -g <package>`. NVM runs within your user directory and prevents permission headaches.
3. **Clean Upgrades**: You can test the latest LTS release without breaking previous project dependencies.

---

## Step 1: Install NVM for Windows

Open **PowerShell as Administrator** and install `nvm-windows` using **Winget** (or Chocolatey):

### Method A: Via Winget (Recommended)
```powershell
winget install CoreyButler.NVMforWindows
```

### Method B: Via Chocolatey
```powershell
choco install -y nvm
```

> [!NOTE]
> If you already had an older, standalone version of Node.js installed previously, NVM will ask if you want it to manage existing installations. Click **Yes**.

---

## Step 2: Install Node.js LTS and Set as Active

Close your current PowerShell and open a **new PowerShell window as Administrator**.

1. Check that NVM is recognized:
   ```powershell
   nvm version
   ```
   *(Should print `1.1.x` or higher).*

2. Install the latest Long-Term Support (LTS) release of Node.js:
   ```powershell
   nvm install lts
   ```

3. Tell NVM to use this version:
   ```powershell
   nvm use lts
   ```
   *(If prompted with a UAC confirmation popup, click Yes to allow NVM to create the symlink).*

---

## Step 3: Quick Verification & Testing

Let's verify that Node.js and its package manager (`npm`) are correctly linked to your PATH and fully operational:

### 1. Check Version Outputs:
```powershell
node -v
npm -v
```

### 2. Run a One-Line Interactive Test:
Run this quick command to verify the V8 JavaScript engine:
```powershell
node -e "console.log('🎉 Success: Node.js ' + process.version + ' is active via NVM!')"
```

### 3. (Optional) Test Running a Mini Server:
Run this one-liner in PowerShell to spin up a quick local web server:
```powershell
node -e "require('http').createServer((req, res) => res.end('Hello from Node on Windows!')).listen(3000, () => console.log('Server running at http://localhost:3000'));"
```
Open [http://localhost:3000](http://localhost:3000) in your browser. You will see `Hello from Node on Windows!`. Press `Ctrl + C` in PowerShell to stop the server.

---

## 🛠️ Handy NVM Commands for Later

- List all installed Node versions: `nvm list`
- List all available versions to install: `nvm list available`
- Install a specific version: `nvm install 20.18.0`
- Switch versions: `nvm use 20.18.0`

---

👉 **Next Step**: Proceed to **[05. Compilers & PATH Configuration](./05-compilers-and-path.md)**.
