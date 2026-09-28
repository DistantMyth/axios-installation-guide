# 10. Web3 & Solana Development Setup

If you are joining the Web3 Wing / Onchain IIITL or building decentralized applications (dApps), install the Rust and Solana development toolchains natively on macOS.

---

## Step 1: Install Rust (Rustup Toolchain)

Solana and Anchor programs are built with Rust.

1. Install `rustup`:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. When prompted, press `1` and hit Enter (default installation).
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

2. Add Solana CLI to your PATH in `~/.zprofile` and `~/.zshrc`:
   ```bash
   echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.zprofile
   echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. Verify Solana CLI:
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

   > [!TIP]
   > **Apple Silicon (M1/M2/M3/M4) Note:**
   > Ensure Apple's Rosetta 2 translation layer is installed for full compatibility when compiling certain Solana SBF toolchain dependencies:
   > ```bash
   > softwareupdate --install-rosetta --agree-to-license
   > ```

---

## Step 3: Install Anchor Version Manager (AVM) & Anchor CLI

Anchor is the standard framework for Solana smart contract development.

1. Install `avm` via Cargo:
   ```bash
   cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
   ```
   *(☕ Note: This step compiles from source and takes 5–10 minutes. Let it run to completion).*

2. Verify `avm`:
   ```bash
   avm --version
   ```

3. Install and set the latest Anchor CLI:
   ```bash
   avm install latest
   avm use latest
   ```

4. Verify Anchor:
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

If `anchor build` finishes without errors, your macOS Solana dev environment is ready! 🎉

---

👉 **macOS Setup is Complete!** You are now ready to build and compete.
- Run the one-click checkup script to audit your setup: **[Quick Verification Checklist](../checklist.md)**.
- Return to the **[Installation Overview](../README.md)**.
