# 03. C++ Compilers: Apple Clang vs GCC & `<bits/stdc++.h>` Fix

If you come from Windows or Linux, C++ on macOS will initially surprise you. Understanding Apple's compiler interception and setting up genuine GNU GCC is critical for competitive programming and college computer science courses.

---

## ⚠️ The Problem: Apple Clang & Missing `<bits/stdc++.h>`

When you type `gcc` or `g++` in the macOS Terminal, Apple automatically intercepts the command and redirects it to **Apple Clang** (Xcode's LLVM compiler).

Apple Clang **does not include** the GNU C++ header `<bits/stdc++.h>`, which is the universal standard in competitive programming (Codeforces, CodeChef, LeetCode) and Indian college curricula. Trying to compile code that includes it results in:

```text
fatal error: 'bits/stdc++.h' file not found
#include <bits/stdc++.h>
         ^~~~~~~~~~~~~~~
1 error generated.
```

Furthermore, simply adding `alias g++="g++-14"` in your `~/.zshrc` does **not** work inside VS Code extensions (like **CPH** or **Code Runner**), because extensions do not expand shell aliases!

---

## The Permanent Fix: Install Real GNU GCC & Binary Symlinks

### Step 1: Install GNU GCC via Homebrew
In Terminal, run:

```zsh
brew install gcc
```
*(This downloads genuine GNU GCC and G++. It may take a couple of minutes).*

---

### Step 2: Create Binary Symlinks in `~/.local/bin`

By creating real binary symlinks inside `~/.local/bin` and placing `~/.local/bin` at the front of your PATH, every tool—the macOS Terminal, VS Code, CPH, and Code Runner—will automatically use genuine GNU GCC!

Run this script in your Terminal:

```zsh
# 1. Automatically detect the installed GCC major version (e.g. 14):
GCC_VER=$(brew list --versions gcc | awk '{print $2}' | cut -d. -f1)

# 2. Create local binary directory:
mkdir -p ~/.local/bin

# 3. Create symlinks pointing directly to Homebrew's GNU gcc and g++:
ln -sf "$(brew --prefix)/bin/gcc-$GCC_VER" ~/.local/bin/gcc
ln -sf "$(brew --prefix)/bin/g++-$GCC_VER" ~/.local/bin/g++

# 4. Add ~/.local/bin to the front of PATH in ~/.zshrc:
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# 5. Add python alias to python3 for convenience:
if ! grep -q 'alias python="python3"' ~/.zshrc; then
  echo 'alias python="python3"' >> ~/.zshrc
fi

# 6. Apply changes immediately:
source ~/.zshrc
```

---

### Step 3: Verify That `g++` is Genuine GNU GCC

Run:

```zsh
g++ --version
```

Look at the output:
- **Correct**: It must state `g++ (Homebrew GCC ...) 14.x.x`
- **Incorrect**: If it states `Apple clang version ...`, verify that `echo $PATH` lists `/Users/yourusername/.local/bin` before `/usr/bin`.

---

### Step 4: Test Compiling `<bits/stdc++.h>`

Run this test script in Terminal:

```zsh
cat << 'EOF' > test.cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cout << "🎉 Success: GNU GCC with <bits/stdc++.h> is working on macOS!" << endl;
    return 0;
}
EOF

g++ test.cpp -o test && ./test
```

If it prints:
```text
🎉 Success: GNU GCC with <bits/stdc++.h> is working on macOS!
```
Your C++ setup is 100% complete and fully compatible with VS Code, CPH, and competitive programming! Clean up the test files:
```zsh
rm -f test test.cpp
```

---

👉 **Next Step**: Proceed to **[04. `uv` Setup (Python)](./04-uv-setup.md)**.
