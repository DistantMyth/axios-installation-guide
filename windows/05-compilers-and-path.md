# 05. C/C++ Compilers (MSYS2 + GCC) & PATH Setup

In competitive programming, Data Structures & Algorithms (DSA), and college coursework, C++ is the most popular language due to its execution speed and rich standard library.

Competitive programming in particular relies heavily on **GNU C++ extensions**:
- The master header `<bits/stdc++.h>` (which pre-includes all standard library headers in one line).
- **Policy-Based Data Structures (PBDS)** like `ordered_set` (`<ext/pb_ds/assoc_container.hpp>` and `<ext/pb_ds/tree_policy.hpp>`), which support finding the $k$-th element in $O(\log n)$ and counting elements smaller than a key in $O(\log n)$.

> [!WARNING]
> **Why We Do NOT Use Standalone Chocolatey MinGW:**
> Traditional standalone MinGW / WinLibs builds installed via Chocolatey often fail to compile standard `ordered_set` templates due to header incompatibility or missing CRT support.
>
> To ensure **100% bug-free compatibility** with all contest platforms (Codeforces, CodeChef, AtCoder) and college labs, we install **MSYS2 with the modern UCRT64 toolchain** (Universal C Runtime).

---

## 1. Fix Windows App Execution Aliases (Critical)

Windows 10 and 11 come with built-in "app execution aliases" that intercept terminal commands like `python` or `python3` and open the Microsoft Store instead of running your compiler or runtime.

> [!CAUTION]
> **Disable this immediately before continuing:**
> 1. Press `Windows Key`, type **Manage app execution aliases**, and hit **Enter** (or navigate to **Settings** > **Apps** > **Advanced app settings** > **App execution aliases**).
> 2. Scroll through the list and toggle **OFF** both:
>    - `python.exe` (App Installer)
>    - `python3.exe` (App Installer)

---

## 2. Install MSYS2 via Winget

Open **Command Prompt** or **PowerShell** from the Start Menu and run:

```powershell
winget install MSYS2.MSYS2
```

This installs MSYS2 to the standard location `C:\msys64`.

---

## 3. Install GCC / G++ in MSYS2 UCRT64

1. Open the Windows Start Menu, search for **MSYS2 UCRT64**, and launch it.
   *(Make sure to open **MSYS2 UCRT64**, not MSYS2 MSYS or CLANG64).*
2. Inside the MSYS2 UCRT64 terminal, run the following command to install the full 64-bit GCC compiler toolchain:

```bash
pacman -S --noconfirm mingw-w64-ucrt-x86_64-toolchain
```

When prompted with `Enter a selection (default=all):`, simply press **Enter** to install all packages.

This installs:
- `gcc` (GNU C Compiler)
- `g++` (GNU C++ Compiler)
- `gdb` (GNU Debugger)
- `make` and essential compilation tools and header libraries (including PBDS).

---

## 4. Add GCC to Environment PATH

To allow PowerShell, Command Prompt, VS Code, and terminal scripts to run `g++` and `gcc` from anywhere, add the MSYS2 UCRT64 binary folder to your user PATH:

1. Press `Windows Key`, search for **"Environment Variables"**, and click **Edit the system environment variables**.

   ![Windows Search Environment Variables](../images/windows-search-env-variables.png)

2. In the System Properties window, click the **Environment Variables...** button.
3. Under the top section titled **User variables for `<YourUsername>`**, select the variable named **Path** and click **Edit...**.
4. Click **New** on the right side and type:
   ```text
   C:\msys64\ucrt64\bin
   ```
5. With `C:\msys64\ucrt64\bin` selected, click the **Move Up** button repeatedly until it is at the **very top** of the list.

   ![MSYS2 UCRT64 Path moved to top](../images/windows-env-path-msys2-top.png)

   > [!IMPORTANT]
   > **Move it to the Top:**
   > In other setups, if any older compiler paths were previously added (for example, an old `C:\tools\mingw64\bin` or Strawberry Perl), keep them below the MSYS2 path or remove them. Having `C:\msys64\ucrt64\bin` at the top guarantees Windows always invokes this modern UCRT64 compiler.

6. Click **OK** on all open dialogs to save your changes.
7. **Close and reopen VS Code and any open PowerShell/Command Prompt windows** to load the new PATH.

---

## 5. Configure VS Code for C/C++

1. Open **VS Code** with your project folder.
2. Ensure the **C/C++** extension (by Microsoft) is installed and enabled.
3. Press `Ctrl + Shift + P` to open the Command Palette, type **C/C++: Edit Configurations (UI)**, and hit **Enter**.
4. Configure the following fields:
   - **Compiler path**: Set to:
     ```text
     C:\msys64\ucrt64\bin\g++.exe
     ```
     ![Set Compiler Path](../images/vscode-c-cpp-config-compiler-path.png)
   - **IntelliSense mode**: Set to `gcc-x64`.
     ![Set IntelliSense Mode](../images/vscode-c-cpp-config-intellisense-mode.png)
   - **C++ standard**: Set to `c++17` (or `c++20`).
     ![Set C++ Standard](../images/vscode-c-cpp-config-standards.png)

### 💡 Additional Pro-Tips for VS Code:
- **Enable Auto-Save**: Press `Ctrl + Shift + P`, search for **File: Toggle Auto Save**, and click it to turn on auto-save so your code is always saved before running.
  ![Toggle Auto Save](../images/vscode-file-toggle-autosave.png)
- **Configure Code Runner (Interactive Terminal)**:
  Open Settings (`Ctrl + ,`):
  - Search `Run In Terminal` → Check **Code-runner: Run In Terminal** (so programs with `cin` don't freeze in the Output tab).
    ![Code Runner Run in Terminal](../images/vscode-code-runner-run-in-terminal.png)
  - Search `Save File Before Run` → Check **Code-runner: Save File Before Run**.
    ![Code Runner Save Before Run](../images/vscode-code-runner-save-before-run.png)

---

## 6. Verify in PowerShell

Open a new **PowerShell** window and run:

```powershell
gcc --version
g++ --version
gdb --version
```

All three should report GNU versions from `RevX, Built by MSYS2 project`.

---

## 7. Test 1: Standard C++ Compilation (`main.cpp`)

Verify standard single-file execution with `<bits/stdc++.h>`:

1. Create a file named `main.cpp`:
   ```cpp
   #include <bits/stdc++.h>
   using namespace std;

   int main() {
       int a, b;
       cin >> a >> b;
       cout << a + b << '\n';
       return 0;
   }
   ```

2. Open the terminal and compile:
   ```powershell
   g++ -std=c++17 -O2 main.cpp -o main.exe
   ```

3. Run the executable:
   ```powershell
   .\main.exe
   ```

4. Type `5 7` and press **Enter**.
   Expected output:
   ```text
   12
   ```

---

## 8. Test 2: Policy-Based Data Structure (`ordered_set`) (`test.cpp`)

To confirm that your compiler handles complex contest templates without compilation errors:

1. Create a file named `test.cpp`:
   ```cpp
   #include <bits/stdc++.h>
   #include <ext/pb_ds/assoc_container.hpp>
   #include <ext/pb_ds/tree_policy.hpp>

   using namespace std;
   using namespace __gnu_pbds;

   template<class T>
   using ordered_set = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;

   int main() {
       ordered_set<int> s;
       s.insert(10);
       s.insert(20);
       s.insert(30);

       // 1. find_by_order(k): returns iterator to the k-th smallest element (0-indexed)
       cout << *s.find_by_order(1) << '\n';

       // 2. order_of_key(k): returns count of elements strictly smaller than k
       cout << s.order_of_key(25) << '\n';

       return 0;
   }
   ```

2. Compile:
   ```powershell
   g++ -std=c++17 -O2 test.cpp -o test.exe
   ```

3. Run:
   ```powershell
   .\test.exe
   ```

4. Expected output:
   ```text
   20
   2
   ```

> [!NOTE]
> - `*s.find_by_order(1)` returns the 2nd smallest element (`20`), because 0-index is `10`.
> - `s.order_of_key(25)` returns `2` because there are two elements (`10` and `20`) strictly less than `25`.
>
> If this compiles and prints `20` and `2`, your Windows C++ environment is 100% ready for competitive programming, advanced data structures, and college labs!

---

👉 **Next Step**: Proceed to **[06. Git Setup & Authentication](./06-git-setup.md)**.
