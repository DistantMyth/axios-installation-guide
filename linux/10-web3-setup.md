# 10. Web3 & Solana Development Setup

If you are joining the Web3 Wing / Onchain IIITL or building decentralized applications (dApps), install the Rust and Solana development toolchains natively on Linux.

---

## Step 1: Install Rust (Rustup Toolchain)

Solana smart contracts are written in Rust.

1. Install `rustup`:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. When prompted, press `1` and hit Enter (default install).
3. Reload your shell environment:
   ```bash
   source $HOME/.cargo/env
   ```
4. Verify the Rust compiler and package manager:
   ```bash
   rustc --version
   cargo --version
   ```

---

## Step 2: Install Solana CLI

1. Run the official Solana installer script:
   ```bash
   sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
   ```

2. Add Solana CLI to your PATH in `~/.bashrc`:
   ```bash
   echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Verify Solana CLI:
   ```bash
   solana --version
   ```

4. Configure default cluster to **devnet** and generate your local keypair:
   ```bash
   solana config set --url devnet
   solana-keygen new
   solana address
   ```
   > [!WARNING]
   > Save the printed recovery seed phrase somewhere safe offline!

---

## Step 3: Install Anchor Version Manager (AVM) & Anchor CLI

Anchor is the premier framework for building Solana smart contracts.

1. Install build dependencies required for compiling `avm` from source:
   - **Debian / Ubuntu / Linux Mint:**
     ```bash
     sudo apt update && sudo apt install -y pkg-config libssl-dev libudev-dev
     ```
   - **Arch Linux / Manjaro:**
     ```bash
     sudo pacman -S --needed pkgconf openssl
     ```
   - **Fedora / RHEL:**
     ```bash
     sudo dnf install -y pkgconf-pkg-config openssl-devel systemd-devel
     ```

2. Install `avm` via Cargo:
   ```bash
   cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
   ```
   *(☕ Note: This step compiles from source and takes 5–10 minutes. Let it run to completion).*

3. Verify `avm`:
   ```bash
   avm --version
   ```

4. Install the Anchor framework CLI using `avm`:
   ```bash
   avm install latest
   avm use latest
   ```

5. Verify Anchor CLI:
   ```bash
   anchor --version
   ```

---

## Step 4: Smoke-Test Your Full Solana Environment

Verify your setup by initializing and building a new Anchor test project:

```bash
cd ~
anchor init my-first-project
cd my-first-project
anchor build
```

If `anchor build` finishes without errors, your Linux Solana dev environment is ready! 🎉

---

👉 **Linux Setup is Complete!** You are now ready to build and compete.
- Run the one-click checkup script to audit your setup: **[Quick Verification Checklist](../checklist.md)**.
- Return to the **[Installation Overview](../README.md)**.
