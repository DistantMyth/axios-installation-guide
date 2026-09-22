# 06. Git Setup & GitHub SSH Authentication

Connecting your Linux machine to GitHub using an SSH key eliminates the need to remember credentials or deal with temporary personal access tokens.

---

## Step 1: Set Global Git Identity

Open your terminal and configure your name and the exact email associated with your GitHub account:

```bash
git config --global user.name "Your Real Name"
git config --global user.email "your_github_email@example.com"
```

Configure optimal defaults for modern Linux development:
```bash
git config --global init.defaultBranch main
git config --global core.autocrlf input
```
*(On Linux, `core.autocrlf input` converts CRLF line endings to LF upon commit, preventing Windows-style carriage return problems).*

---

## Step 2: Generate an Ed25519 SSH Key

1. Generate a modern, highly secure SSH key pair:
   ```bash
   ssh-keygen -t ed25519 -C "your_github_email@example.com"
   ```

2. When prompted:
   - `Enter file in which to save the key`: Press **Enter** to accept the default (`~/.ssh/id_ed25519`).
   - `Enter passphrase`: Press **Enter** twice for no passphrase (recommended for personal computers).

---

## Step 3: Copy Your Public Key to Clipboard

### Method A: Direct Command Line Copy
- **On modern Wayland desktops (Ubuntu 22.04+, Fedora Workstation, Debian GNOME):**
  ```bash
  sudo apt install -y wl-clipboard     # Ubuntu/Debian
  sudo dnf install -y wl-clipboard     # Fedora
  sudo pacman -S --needed wl-clipboard # Arch Linux
  wl-copy < ~/.ssh/id_ed25519.pub
  ```
- **On X11 desktops (Linux Mint Cinnamon/XFCE, older distros):**
  ```bash
  sudo apt install -y xclip
  xclip -selection clipboard < ~/.ssh/id_ed25519.pub
  ```

### Method B: Terminal Output Copy
Alternatively, display your key in the terminal:
```bash
cat ~/.ssh/id_ed25519.pub
```
Select the entire printed string (starting with `ssh-ed25519 AAAAC3...` up to your email) and press `Ctrl + Shift + C` to copy.

---

## Step 4: Add the SSH Key to GitHub

1. Open your browser and go to [github.com](https://www.github.com).
2. Click your profile avatar in the upper right > **Settings**.
3. In the left navigation menu, click **SSH and GPG keys**.
4. Click the green **New SSH key** button.
5. Provide:
   - **Title**: `My Linux Machine` (e.g. `Ubuntu-ThinkPad`).
   - **Key type**: `Authentication Key`.
   - **Key**: Paste your public key (`Ctrl + V`).
6. Click **Add SSH key**.

---

## Step 5: Verify Connection

In your terminal, test your connection to GitHub:

```bash
ssh -T git@github.com
```

- When prompted:
  ```text
  The authenticity of host 'github.com' can't be established.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```
  Type `yes` and hit **Enter**.

- You should receive:
  ```text
  Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.
  ```

Your Linux system is now fully authenticated with GitHub!

---

👉 **Next Step**: Proceed to **[07. Java Development Setup](./07-java-setup.md)**.
