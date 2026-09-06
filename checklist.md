# 6. Quick Verification Checklist

Before starting your college lab or contest, run through this quick checklist to confirm everything is working smoothly.

---

## 📑 Table of Contents

- [1. Developer & Contest Accounts](#-1-developer--contest-accounts)
- [2. VS Code & Extensions](#-2-vs-code--extensions)
- [3. Compiler & Test Code](#-3-compiler--test-code)
- [4. Command Line Tools](#-4-command-line-tools)
- [5. Git & GitHub Authentication](#-5-git--github-authentication)
- [6. Browser Extensions](#-6-browser-extensions)
- [7. WSL & CTF Toolkit (Windows)](#-7-wsl-and-ctf-toolkit-windows)

---

## 📋 Readiness Checklist

### 🌐 1. Developer & Contest Accounts
- [ ] **GitHub**: Account created and logged in.
- [ ] **Codeforces**: Account registered and email verified.
- [ ] **CodeChef**: Account registered, student details filled (IIIT Lucknow).
- [ ] **Kaggle**: Account registered & phone verified (~30 hrs/week free GPU unlocked).
- [ ] **Hugging Face**: Account registered & email confirmed.

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
- [ ] Test C++ file compiles with `<bits/stdc++.h>`:
  ```cpp
  #include <bits/stdc++.h>
  using namespace std;

  int main() {
      cout << "Environment is 100% ready!" << endl;
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
- [ ] **Competitive Companion** extension installed in your web browser.
- [ ] **Carrot** extension installed for Codeforces contest predictions.

---

### 🧑‍💻 7. WSL and CTF Toolkit (Windows)

For Windows users using WSL: open your **Ubuntu** terminal (search "Ubuntu" in the Start Menu) and verify:

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

---

🎉 **You are all set! Welcome to the college developer community!**

Return to the **[Basic Installation Overview](README.md)**. 
