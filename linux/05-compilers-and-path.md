# 05. Compilers & Shell PATH Configuration

Linux natively uses GNU GCC (`gcc` / `g++`) and GDB (`gdb`). This guide ensures your compiler flags, paths, and competitive programming headers are fully functioning.

---

## 1. Verifying C/C++ Compilers and Debugger

Open your terminal and run:

```bash
gcc --version
g++ --version
gdb --version
```

All three should display genuine GNU compiler versions (e.g., `gcc (Ubuntu ...) 13.x` or similar).

---

## 2. Environment Variables & PATH Configuration

On Linux, custom user tools (such as `uv`, Python CLI tools, and user scripts) are placed in `~/.local/bin`.

To ensure this directory is always searched by your terminal:

### If using Bash (Ubuntu, Debian, Fedora, Mint):
```bash
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi
source ~/.bashrc
```

### If using Zsh (Manjaro, Kali, Arch with zsh):
```bash
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi
source ~/.zshrc
```

---

## 3. Test Compiling C++ with `<bits/stdc++.h>`

Unlike macOS (which defaults to Apple Clang), Linux GNU GCC natively includes `<bits/stdc++.h>`.

Let's verify your compilation and execution:

```bash
# Create a test C++ program
cat << 'EOF' > test.cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    vector<string> items = {"Linux", "GCC", "bits/stdc++.h"};
    cout << "Success: ";
    for (const auto& item : items) cout << "[" << item << "] ";
    cout << "working flawlessly!" << endl;
    return 0;
}
EOF

# Compile with standard flags used in Codeforces & college labs:
g++ -O3 -Wall test.cpp -o test && ./test
```

If it prints:
```text
Success: [Linux] [GCC] [bits/stdc++.h] working flawlessly!
```
Your C/C++ compiler setup is completely ready! Clean up the test files with:
```bash
rm -f test test.cpp
```

---

👉 **Next Step**: Proceed to **[06. Git Setup & Authentication](./06-git-setup.md)**.
