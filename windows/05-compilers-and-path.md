# 05. Compilers & Environment Variables (PATH)

Now we will configure and verify that your C/C++ compiler (`gcc`/`g++`) and Python runtime are registered properly in Windows and accessible from any terminal window.

---

## 1. Fix Windows App Execution Aliases (Critical)

> [!CAUTION]
> **Prevent Windows from opening the Microsoft Store on `python`!**
> Windows 10 and 11 come with built-in "app execution aliases" that intercept commands like `python` or `python3` in your terminal and open the Microsoft Store download page instead of executing your installed Python!
>
> **How to fix this immediately:**
> 1. Press `Windows Key`, type **Manage app execution aliases**, and hit Enter (or go to **Settings** > **Apps** > **Advanced app settings** > **App execution aliases**).
> 2. Scroll through the list and toggle **OFF** both:
>    - `python.exe` (App Installer)
>    - `python3.exe` (App Installer)

---

## 2. What is the PATH Environment Variable?

Think of your computer as a library. When you type `gcc`, `python`, or `git` into PowerShell, Windows searches the directories listed in your **PATH** variable. If a compiler's folder is missing from PATH, Windows reports:
`The term 'gcc' is not recognized as the name of a cmdlet...`

Chocolatey registers most tools automatically, but MinGW (`gcc`/`g++`) often requires verifying the bin directory.

---

## 3. Step-by-Step PATH Verification (GUI Method)

1. Press `Windows Key + R`, type `sysdm.cpl`, and hit **Enter** (opens System Properties).
   
   ![System Properties](../images/system-properties-run-sysdm.png)

2. In the System Properties dialog, switch to the **Advanced** tab and click the **Environment Variables...** button at the bottom:
   
   ![Environment Variables Button](../images/system-properties-environment-variables.png)

3. Under the bottom pane titled **System variables**, select the variable named **Path** and click **Edit...**:
   
   ![Edit System Variable Path](../images/environment-variables-edit-path.png)

4. Look through the list for the MinGW binary folder (typically `C:\tools\mingw64\bin` or `C:\ProgramData\chocolatey\bin`):
   
   ![MinGW Path in List](../images/edit-environment-variable-mingw-path.png)

   - If `C:\tools\mingw64\bin` is **not** present:
     1. Click **New** on the right.
     2. Type or paste: `C:\tools\mingw64\bin`
     3. Click **OK** on all three open windows to save the changes.

---

## 4. Verify in a Fresh Terminal

Close all existing terminal windows, open a new **PowerShell** or **Command Prompt**, and run:

```powershell
gcc --version
g++ --version
python --version
uv --version
node -v
git --version
```

![Terminal Verification](../images/verify-tools-terminal.png)

---

## 5. Test Compiling C++ with `<bits/stdc++.h>`

To confirm that your C++ compiler is ready for competitive programming and college coursework:

1. Open PowerShell and run this one-liner to create a test program:
   ```powershell
   Set-Content -Path test.cpp -Value @"
   #include <bits/stdc++.h>
   using namespace std;
   int main() {
       cout << "MinGW GCC works perfectly with bits/stdc++.h!" << endl;
       return 0;
   }
   "@
   ```

2. Compile and run it:
   ```powershell
   g++ test.cpp -o test.exe; .\test.exe
   ```

If it prints `MinGW GCC works perfectly with bits/stdc++.h!`, your C/C++ compiler setup is 100% complete! You can clean up the test files with `Remove-Item test.cpp, test.exe`.

---

👉 **Next Step**: Proceed to **[06. Git Setup & Authentication](./06-git-setup.md)**.
