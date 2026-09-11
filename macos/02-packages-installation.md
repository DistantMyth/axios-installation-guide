# 02. Core Packages & VS Code Installation via Homebrew

With Homebrew configured, we can install our core developer toolset and Visual Studio Code.

---

## Step 1: Install Command-Line Tools

Run the following command in Terminal:

```zsh
brew install git python wget sevenzip
```

### What This Installs:
- `git`: Upgrades macOS's outdated bundled Apple Git to the latest official Git release.
- `python`: Installs Python 3.12+ and `pip3`.
- `wget`: Standard GNU command-line file download utility.
- `sevenzip`: Modern 7-Zip compression and decompression tool.

*(Note: macOS already includes a modern, high-performance version of `curl` natively).*

---

## Step 2: Install Visual Studio Code

Homebrew allows installing graphical desktop applications cleanly using `casks`:

```zsh
brew install --cask visual-studio-code
```

After installation finishes, you can launch VS Code from Spotlight (`Cmd + Space` -> `Visual Studio Code`) or directly from Terminal using:
```zsh
code .
```

---

> [!NOTE]
> **What about C++ compilers, `uv`, and Node.js?**
> - In **[03-compilers-setup.md](./03-compilers-setup.md)**, we resolve the famous Mac Apple Clang vs. GNU GCC problem to get `#include <bits/stdc++.h>` working.
> - In **[04-uv-setup.md](./04-uv-setup.md)**, we set up Astral's `uv`.
> - In **[05-nvm-setup.md](./05-nvm-setup.md)**, we install **NVM** for Node.js.

---

👉 **Next Step**: Proceed to **[03. Compilers Setup & `<bits/stdc++.h>` Fix](./03-compilers-setup.md)**.
