# 03. Essential VS Code Setup & Extensions

Visual Studio Code (VS Code) is the industry-standard code editor across college coursework, hackathons, and software engineering teams.

Once you have installed VS Code (via your operating system's package manager in the next section), open it and click the **Extensions** icon on the left Activity Bar (shortcut: `Ctrl + Shift + X` on Windows/Linux, `Cmd + Shift + X` on macOS).

![VS Code Extensions View](../images/Pasted%20image%2020260904174839.png)
![VS Code Extension Marketplace](../images/vs-extension-1.png)

Search for and install the recommended extensions below:

---

## 1. C / C++ & Competitive Programming

### 1.1 C/C++ & C/C++ Extension Pack (by Microsoft)
Provides IntelliSense (code auto-completion), parameter hints, syntax highlighting, and debugging integration for C and C++.

![C/C++ Extension](../images/Pasted%20image%2020260904175101.png)

---

### 1.2 Competitive Programming Helper (cph) (by Divyanshu Agrawal)
An indispensable tool for competitive programmers.
- Automatically receives test cases sent from your browser's *Competitive Companion* extension.
- Runs your C++, Python, or Java solution against all sample test cases side-by-side.
- Shows time elapsed, memory used, expected vs. actual output, and verdicts (Passed / Wrong Answer / Time Limit Exceeded).
- **Shortcut to run test cases**: `Ctrl + Alt + B` (Windows/Linux) or `Cmd + Option + B` (macOS), or click the green **Run** button in the CPH sidebar.

![CPH Extension](../images/vs-extension-2.png)

---

### 1.3 Code Runner (by Jun Han)
Run standalone single code files (C, C++, Python, Java, JS, Rust, etc.) with a single click or keyboard shortcut (`Ctrl + Alt + N` / `Cmd + Option + N`).

> [!IMPORTANT]
> **Critical Setting: Enable Terminal Input for Code Runner**
>
> By default, Code Runner executes scripts in the VS Code **Output** tab. The Output tab is read-only, which means programs that require interactive user input (e.g., `cin >> x;`, `scanf()`, or `input()`) will freeze waiting for input!
>
> **To fix this:**
> 1. Open VS Code Settings (`Ctrl + ,` on Windows/Linux, `Cmd + ,` on macOS).
> 2. Search for: `code-runner.runInTerminal`
> 3. Check the box for **"Code-runner: Run In Terminal"**.
> 
> Now, pressing the Play button executes your code in the integrated Terminal where you can type inputs!

![Code Runner Configuration](../images/vs-extension-3.png)

---

## 2. Python Development

- **Python** (by Microsoft): Official extension providing rich support for linting, debugging, code navigation, and Jupyter notebook support.
- **Pylance** (by Microsoft): High-performance language server offering type checking, fast auto-complete, auto-imports, and docstring previews.

---

## 3. Web Development

- **Live Server** (by Ritwick Dey): Launches a local development server with live-reload capabilities for static HTML, CSS, and JavaScript. Right-click any `.html` file and choose **"Open with Live Server"**.
- **Prettier - Code Formatter**: Formats your HTML, CSS, JavaScript, TypeScript, and JSON automatically whenever you save (`Ctrl + S`).
- **Auto Rename Tag**: Automatically renames matching opening/closing HTML/XML tags simultaneously.
- **Tailwind CSS IntelliSense**: Autocompletes class names, displays CSS previews on hover, and highlights class errors.

---

## 4. Quality of Life & Themes

- **Error Lens**: Highlights syntax errors, warnings, and type issues directly inline on the active code line, allowing you to catch mistakes before compiling.
- **Material Icon Theme**: Adds clean, distinctive file and folder icons for hundreds of programming languages, frameworks, and file extensions.
- **Dev Containers / WSL**: Enables developing directly inside Linux containers or WSL environments seamlessly.

---

## 🚀 Recommended `settings.json` Snippet

To apply standard editor optimizations, press `Ctrl + Shift + P` (or `Cmd + Shift + P`), type **Preferences: Open User Settings (JSON)**, and add or merge the following properties:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "code-runner.runInTerminal": true,
  "code-runner.saveFileBeforeRun": true,
  "code-runner.clearPreviousOutput": true,
  "files.autoSave": "afterDelay"
}
```

---

👉 **You are now ready for OS-specific installation!**
- 🪟 Windows Users: **[Windows Setup Guide](../windows/README.md)**
- 🐧 Linux Users: **[Linux Setup Guide](../linux/README.md)**
- 🍎 macOS Users: **[macOS Setup Guide](../macos/README.md)**
