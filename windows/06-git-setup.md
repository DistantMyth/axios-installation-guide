# 06. Git Setup & GitHub SSH Authentication

Git tracks revisions to your code, while GitHub stores your repositories in the cloud. Instead of entering your username and password or generating fragile personal access tokens every time you push code, we will set up **SSH keys**, which provide secure, seamless, one-time authentication.

---

## Step 1: Configure Your Global Git Identity

Open PowerShell and run the following commands, replacing the placeholder values with your real name and the exact email address you registered on GitHub:

```powershell
git config --global user.name "Your Real Name"
git config --global user.email "your_github_email@example.com"
```

Configure sensible global defaults for branch naming and line endings:
```powershell
git config --global init.defaultBranch main
git config --global core.autocrlf true
```

---

## Step 2: Generate a Secure Ed25519 SSH Key

1. In PowerShell, generate a modern cryptographic key pair:
   ```powershell
   ssh-keygen -t ed25519 -C "your_github_email@example.com"
   ```

2. When prompted:
   - `Enter file in which to save the key`: Press **Enter** to accept the default location (`$HOME\.ssh\id_ed25519`).
   - `Enter passphrase`: Press **Enter** twice for no passphrase (recommended for beginners on personal laptops so you are not prompted repeatedly).

---

## Step 3: Copy Your Public Key to Clipboard

Run this PowerShell command to load your public key directly into your Windows clipboard:

```powershell
Get-Content "$HOME\.ssh\id_ed25519.pub" -Raw | Set-Clipboard
```

---

## Step 4: Add the SSH Key to Your GitHub Account

1. Open your browser and log into [github.com](https://www.github.com).
2. Click your profile photo in the upper right corner > **Settings**.
3. In the left navigation menu, click **SSH and GPG keys**.
4. Click the green **New SSH key** button.
5. Fill in:
   - **Title**: `My Windows Laptop` (or your machine name).
   - **Key type**: `Authentication Key`.
   - **Key**: Press `Ctrl + V` to paste your key from the clipboard (it starts with `ssh-ed25519`).
6. Click **Add SSH key**. Enter your GitHub password or passkey if prompted.

---

## Step 5: Test Your GitHub Connection

In your PowerShell window, test the SSH link:

```powershell
ssh -T git@github.com
```

- If you see a prompt:
  ```text
  The authenticity of host 'github.com (IP)' can't be established.
  ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zP0txJWE44NSykJaZsFW4.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```
  Type `yes` and press **Enter**.

- You should receive this success response:
  ```text
  Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.
  ```

🎉 Congratulations! Git is now configured and connected to GitHub. You can clone and push to private and public repositories without entering passwords!

---

👉 **Next Step**: Proceed to **[07. Java Development Setup](./07-java-setup.md)**.
