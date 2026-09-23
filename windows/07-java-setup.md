# 07. Java Development Setup

Java is a core language for college Object-Oriented Programming (OOP), Data Structures & Algorithms (DSA), backend enterprise services (Spring Boot), and Android development.

Unlike C++, which compiles directly into machine code, Java source code (`.java`) compiles into bytecode (`.class`) that executes on the **Java Virtual Machine (JVM)**. To develop Java applications, you need the **Java Development Kit (JDK)**, which includes the compiler (`javac`), runtime (`java`), and developer debugging tools.

> [!IMPORTANT]
> **Stick to Long-Term Support (LTS) Releases:**
> In college labs and production environments, standardize on official **LTS** releases. Today, **Java 21 (LTS)** is the modern standard, while **Java 17 (LTS)** remains common in legacy frameworks. We recommend **Eclipse Temurin** (by the Eclipse Adoptium Working Group), the vendor-neutral, certified open-source distribution of OpenJDK.

You have two great options to set up Java on Windows:
- **Option A (Recommended):** Use **`mise`**, a modern, blazing-fast polyglot tool and runtime manager (written in Rust) that manages parallel JDK versions and automatically handles `JAVA_HOME`.
- **Option B (Direct Windows Install):** Install Eclipse Temurin JDK 21 directly via **Winget** or **Chocolatey**.

---

## Option A: `mise` — Modern JDK & Tool Manager (Recommended)

[mise](https://mise.jdx.dev/) is the modern, cross-platform successor to tools like `asdf` and `sdkman`. It runs natively on Windows PowerShell, macOS, and Linux, and manages multiple parallel versions of Java, Node, Python, and more.

### 1. Install `mise` on Windows

Open **PowerShell** and install via **Winget** (or Chocolatey):

```powershell
winget install jdx.mise
```
*(Or via Chocolatey: `choco install -y mise`)*.

### 2. Activate `mise` in PowerShell

To enable `mise` to automatically configure your active JDK and `JAVA_HOME` in every PowerShell session, add it to your PowerShell profile:

```powershell
if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }
Add-Content -Path $PROFILE -Value "`nmise activate powershell | Out-String | Invoke-Expression"
```
Reload your current session:
```powershell
& $PROFILE
```

### 3. Install & Select Java 21 LTS

With `mise`, installing and setting up Java takes one command:

```powershell
mise use --global java@21
```

`mise` will automatically download certified Eclipse Temurin OpenJDK 21, link the executables, and export `JAVA_HOME` into your environment!

### 4. Useful `mise` Commands for Java:
- **List installed Java versions**: `mise ls java`
- **List all available Java versions**: `mise ls-remote java`
- **Install an older version (e.g. Java 17 for an older project)**:
  ```powershell
  mise install java@17
  ```
- **Switch to Java 17 inside a specific project folder**:
  ```powershell
  mise use java@17
  ```
  *(Creates a `.mise.toml` file in that folder; whenever you navigate to that directory, `mise` automatically switches your active JDK and `JAVA_HOME`!)*

---

## Option B: Native Windows Setup via Winget / Chocolatey

If you prefer a direct, standalone system-wide installation without a version manager:

### 1. Install OpenJDK 21 via Winget or Chocolatey:
Open **PowerShell as Administrator**:

```powershell
# Via Winget (Recommended)
winget install EclipseAdoptium.Temurin.21.JDK

# Or via Chocolatey
choco install -y openjdk
```

### 2. Configure `JAVA_HOME` and PATH:
Temurin typically installs to:
`C:\Program Files\Eclipse Adoptium\jdk-21.x.x-hotspot\`
(Or Chocolatey OpenJDK installs to: `C:\Program Files\OpenJDK\openjdk-21.x.x\`).

Set the system environment variable:
```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Eclipse Adoptium\jdk-21.0.6.7-hotspot", "Machine")
```
*(Ensure the directory path matches the exact folder name inside `C:\Program Files\Eclipse Adoptium\` or `C:\Program Files\OpenJDK\` on your machine, and ensure `%JAVA_HOME%\bin` is added to System PATH).*

---

## Step 3: Verify Java in a New Terminal

Close and reopen PowerShell, then run:

```powershell
java -version
javac -version
```

You should see output similar to:
```text
openjdk version "21.0.x" 202x-xx-xx LTS
OpenJDK Runtime Environment Temurin-21.x.x+x (build 21.0.x+x-LTS)
OpenJDK 64-Bit Server VM Temurin-21.x.x+x (build 21.0.x+x-LTS, mixed mode, sharing)
```

---

## Step 4: Quick Single-File Test

Modern Java allows executing single-source Java files directly without manual `.class` compilation!

Run this in PowerShell:

```powershell
Set-Content -Path Hello.java -Value @"
public class Hello {
    public static void main(String[] args) {
        System.out.println("☕ Hello from Java " + System.getProperty("java.version") + " on Windows!");
    }
}
"@

java Hello.java
```

If it prints `☕ Hello from Java 21... on Windows!`, your Java environment is fully operational! Clean up the test file with `Remove-Item Hello.java`.

---

## 💻 Recommended VS Code Extension for Java

In VS Code, search for and install:
- **Extension Pack for Java** (by Microsoft): Includes language support by Red Hat, debugger for Java, test runner, Maven/Gradle project support, and automatic JDK detection.

---

👉 **Next Step**: Proceed to **[08. WSL2 & Linux Containers](./08-wsl-setup.md)**.
