# 10. Web3 & Solana Development Setup (inside WSL2)

If you are joining the Web3 Wing / Onchain IIITL or building decentralized applications (dApps), install the Rust and Solana development toolchains inside your Linux environment.

---

> [!IMPORTANT]
> **Why install Solana & Anchor inside WSL2?**
> Solana smart contracts are written in Rust, and the Anchor framework is built for Unix/Linux environments. Installing or compiling them natively on Windows PowerShell/CMD often results in broken compilation scripts and linker errors. Running everything inside **WSL2 (Ubuntu)** provides a stable, 100% native Linux environment.

---

## Step 1: Ensure Prerequisites are Installed in WSL

Open your **Ubuntu WSL terminal** and verify that essential C build tools and SSL libraries are present:

```bash
sudo apt update
sudo apt install -y build-essential pkg-config libssl-dev libudev-dev curl git
```

---

## Step 2: Install Rust (Rustup Toolchain)

Solana and Anchor programs are compiled using the Rust toolchain.

1. In your Ubuntu terminal, run:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. When prompted, press `1` and hit Enter (default installation).
3. Once complete, reload your shell environment:
   ```bash
   source $HOME/.cargo/env
   ```
4. Verify the Rust compiler and package manager:
   ```bash
   rustc --version
   cargo --version
   ```

---

## Step 3: Install the Solana CLI Tool Suite

1. Run the official Solana installer script inside Ubuntu:
   ```bash
   sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
   ```

2. Add the Solana binaries to your PATH permanently in `~/.bashrc`:
   ```bash
   echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Verify the Solana CLI is active:
   ```bash
   solana --version
   ```

4. Configure the default cluster to **devnet** and generate your local keypair:
   ```bash
   solana config set --url devnet
   solana-keygen new
   solana address
   ```
   > [!WARNING]
   > Save the 12-word seed phrase printed during `solana-keygen new` somewhere safe offline!

---

## Step 4: Install Anchor Version Manager (AVM)

Anchor is the premier framework for building, testing, and deploying Solana smart contracts (similar to Hardhat/Foundry for Ethereum).

1. Install `avm` via Cargo:
   ```bash
   cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
   ```
   *(☕ Note: This step compiles from source and may take 5–10 minutes depending on your CPU. Let it run to completion).*

2. Verify that `avm` is available:
   ```bash
   avm --version
   ```

---

## Step 5: Install Anchor Framework CLI

1. Use `avm` to install and activate the latest Anchor CLI release:
   ```bash
   avm install latest
   avm use latest
   ```

2. Verify the installation:
   ```bash
   anchor --version
   ```

---

## Step 6: Smoke-Test Your Full Solana Environment

Verify your setup by initializing and building a new Anchor test project:

```bash
cd ~
anchor init my-first-project
cd my-first-project
anchor build
```

If `anchor build` finishes with `Build success`, your Solana & Web3 development environment is 100% operational! 🎉

---

👉 **Windows Setup is Complete!** You are now ready to build and compete.
- Run the one-click checkup script to audit your setup: **[Quick Verification Checklist](../checklist.md)**.
- Return to the **[Installation Overview](../README.md)**.
