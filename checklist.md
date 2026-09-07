# 5. Quick Verification Checklist

Before starting your college lab or contest, run through this quick checklist to confirm everything is working smoothly.

---

## 📑 Table of Contents

- [1. Developer, Contest & Web3 Accounts](#-1-developer-contest--web3-accounts)
- [2. VS Code & Extensions](#-2-vs-code--extensions)
- [3. Compiler & Test Code](#-3-compiler--test-code)
- [4. Command Line Tools](#-4-command-line-tools)
- [5. Git & GitHub Authentication](#-5-git--github-authentication)
- [6. Browser Extensions](#-6-browser-extensions)
- [7. WSL & Linux Advanced Toolkits (CTF & Web3)](#-7-wsl--linux-advanced-toolkits-ctf--web3)

---

## 📋 Readiness Checklist

### 🌐 1. Developer, Contest & Web3 Accounts
- [ ] **GitHub**: Account created and logged in.
- [ ] **Codeforces**: Account registered and email verified.
- [ ] **CodeChef**: Account registered, student details filled (IIIT Lucknow).
- [ ] **Kaggle**: Account registered & phone verified (~30 hrs/week free GPU unlocked).
- [ ] **Hugging Face**: Account registered & email confirmed.
- [ ] **MetaMask**: Wallet extension installed, account created, and Secret Recovery Phrase (SRP) stored safely offline.
- [ ] **Sepolia Testnet**: Test network enabled in MetaMask and test ETH received from faucet.
- [ ] **Phantom**: Solana wallet installed and switched to Solana Devnet.

---

### 💻 2. VS Code & Extensions
- [ ] **VS Code** launches without issues.
- [ ] **C/C++** extension installed.
- [ ] **Competitive Programming Helper (cph)** extension installed.
- [ ] **Code Runner** extension installed.
  - [ ] Setting `code-runner.runInTerminal` is **checked** in VS Code Settings (`Ctrl + ,` or `Cmd + ,`).
- [ ] **Python** & **Pylance** extensions installed.
- [ ] **Jupyter** & **Ruff** extensions installed *(for ML & Data Science)*.

---

### ⚙️ 3. Compiler & Test Code
- [ ] Test C++ file compiles with `<bits/stdc++.h>` and Policy-Based Data Structures (`ordered_set`):
  ```cpp
  #include <bits/stdc++.h>
  #include <ext/pb_ds/assoc_container.hpp>
  #include <ext/pb_ds/tree_policy.hpp>

  #pragma GCC optimize("O3")
  #pragma GCC optimize("unroll-loops")

  #if (defined(__x86_64__) || defined(_M_X64)) && !defined(__APPLE__)
  #pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")
  #endif

  using namespace std;
  using namespace __gnu_pbds;

  // Definition of ordered_set (Policy-Based Data Structure)
  template <typename T>
  using ordered_set = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;

  int main() {
      ordered_set<int> s;
      s.insert(10);
      s.insert(20);
      s.insert(30);

      // find_by_order(k) returns iterator to k-th smallest element (0-indexed)
      cout << "Element at index 1: " << *s.find_by_order(1) << " (Expected: 20)" << endl;

      // order_of_key(k) returns the number of elements strictly smaller than k
      cout << "Elements < 25: " << s.order_of_key(25) << " (Expected: 2)" << endl;
      cout << "Environment is 100% ready for Competitive Programming & PBDS!" << endl;
      return 0;
  }
  ```
  *(Compile and run with `g++ test.cpp -o test && ./test` or press Play in VS Code).*

---

### 🔧 4. Command Line Tools
Run these commands in your terminal to verify that each tool responds with a version number:

| Tool | Verification Command | Expected Output |
| :--- | :--- | :--- |
| **C Compiler** | `gcc --version` | Prints GCC version (or aliased GNU GCC on macOS) |
| **C++ Compiler** | `g++ --version` | Prints G++ version |
| **Python** | `python --version` *(or `python3`)* | `Python 3.x.x` |
| **uv Package Manager** | `uv --version` | `uv 0.x.x` |
| **Node.js** | `node --version` | `v20.x.x` or `v22.x.x` |
| **Git** | `git --version` | `git version 2.x.x` |
| **Rust Compiler** | `rustc --version` | `rustc 1.x.x` *(WSL / Linux)* |
| **Cargo Package Manager** | `cargo --version` | `cargo 1.x.x` *(WSL / Linux)* |
| **Solana CLI** | `solana --version` | `solana-cli x.x.x` *(WSL / Linux)* |
| **Anchor CLI** | `anchor --version` | `anchor-cli 0.x.x` *(WSL / Linux)* |

---

### 🔑 5. Git & GitHub Authentication
- [ ] Git username configured: `git config --global user.name`
- [ ] Git email configured: `git config --global user.email`
- [ ] SSH authentication verified:
  ```bash
  ssh -T git@github.com
  ```
  *(Should output: `Hi <username>! You've successfully authenticated...`)*

---

### 🌐 6. Browser Extensions
- [ ] **Competitive Companion** installed (Firefox / Chrome / Brave).
- [ ] **Carrot** installed for Codeforces live rating predictions.
- [ ] **CF Analytics** installed for detailed contest performance analytics.
- [ ] **Codeforces Rating-Based Heatmap** installed for submission activity tracking.
- [ ] **Codeforces Friends Tracker** installed for friends-only scoreboard filtering.
- [ ] **Codeforces College / Custom Standings** installed for college leaderboard rankings.
- [ ] **CF FetchCodes** installed for one-click accepted solution fetching.
- [ ] **MetaMask** & **Phantom** wallets installed *(for Web3 / Blockchain track)*.

---

### 🧑‍💻 7. WSL & Linux Advanced Toolkits (CTF & Web3)

For Windows users (inside WSL Ubuntu) and native Linux users, verify your advanced domain toolchains:

- [ ] **Core Compilers & Build Tools:**
  - `gcc --version`
  - `make --version`
- [ ] **Linux Python & Git:**
  - `python3 --version`
  - `git --version`
- [ ] **Cybersecurity / CTF Tools:**
  - `exiftool -ver`
  - `nmap --version`
  - `binwalk --version`
  - `steghide --version`
  - `nc -h`
- [ ] **Web3 & Solana Development Tools:**
  - `rustc --version` & `cargo --version`
  - `solana --version`
  - `solana address` (prints valid local base58 wallet address)
  - `avm --version` & `anchor --version`
  - Smoke test: `anchor build` compiles successfully inside a test Anchor project (`my-first-project`).

---

🎉 **You are all set! Welcome to the college developer community!**

Return to the **[Basic Installation Overview](README.md)**. 
