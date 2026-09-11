# 06. Git Setup & GitHub SSH Authentication

Setting up Git with SSH authentication connects your Mac to GitHub without needing passwords or personal access tokens.

---

## Step 1: Set Global Git Identity

Open Terminal and configure your name and the exact email address used for your GitHub account:

```zsh
git config --global user.name "Your Real Name"
git config --global user.email "your_github_email@example.com"
```

Configure optimal defaults for modern macOS development:
```zsh
git config --global init.defaultBranch main
git config --global core.autocrlf input
```

---

## Step 2: Generate an Ed25519 SSH Key

1. In Terminal, generate a modern cryptographic key pair:
   ```zsh
   ssh-keygen -t ed25519 -C "your_github_email@example.com"
   ```

2. When prompted:
   - `Enter file in which to save the key`: Press **Enter** to accept the default location (`~/.ssh/id_ed25519`).
   - `Enter passphrase`: Press **Enter** twice for no passphrase (recommended for personal Macs).

---

## Step 3: Copy Your Public Key to Clipboard

On macOS, you can copy the public key directly to your system clipboard using the built-in `pbcopy` command:

```zsh
pbcopy < ~/.ssh/id_ed25519.pub
```

*(Your public key is now copied to your clipboard).*

---

## Step 4: Add the SSH Key to GitHub

1. Open your browser and go to [github.com](https://www.github.com).
2. Click your profile avatar in the upper right corner > **Settings**.
3. In the left navigation menu, click **SSH and GPG keys**.
4. Click the green **New SSH key** button.
5. Fill in:
   - **Title**: `My MacBook` (e.g. `MacBook-Air-M3`).
   - **Key type**: `Authentication Key`.
   - **Key**: Press `Cmd + V` to paste your key from the clipboard.
6. Click **Add SSH key**.

---

## Step 5: Verify Connection

In your Terminal, test your connection to GitHub:

```zsh
ssh -T git@github.com
```

- When prompted:
  ```text
  The authenticity of host 'github.com' can't be established.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```
  Type `yes` and press **Enter**.

- You should see:
  ```text
  Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.
  ```

Your Mac is now fully authenticated with GitHub!

---

👉 **Next Step**: Proceed to **[07. Java Development Setup](./07-java-setup.md)**.
