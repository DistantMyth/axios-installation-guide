# 07. Java Development Setup

Java is a core language for college Object-Oriented Programming (OOP), Data Structures & Algorithms (DSA), backend enterprise services (Spring Boot), and Android development.

We will install **Eclipse Temurin OpenJDK 21 (LTS)**, the community-standard, free, open-source JDK built by the Eclipse Adoptium Working Group.

---

## Step 1: Install OpenJDK 21 LTS

Open **PowerShell as Administrator** and install via **Winget** (or Chocolatey):

### Method A: Via Winget (Recommended)
```powershell
winget install EclipseAdoptium.Temurin.21.JDK
```

### Method B: Via Chocolatey
```powershell
choco install -y openjdk
```

---

## Step 2: Configure `JAVA_HOME` and PATH

Many build tools (Maven, Gradle), IDEs, and Android SDKs require a system variable named `JAVA_HOME` that points to the root directory of your Java installation.

### 1. Identify the Install Directory:
Temurin typically installs to:
`C:\Program Files\Eclipse Adoptium\jdk-21.x.x-hotspot\`
(Or Chocolatey OpenJDK installs to: `C:\Program Files\OpenJDK\openjdk-21.x.x\`).

### 2. Set System Environment Variable (PowerShell One-Liner):
Run the following in Administrator PowerShell to set `JAVA_HOME` automatically:

```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Eclipse Adoptium\jdk-21.0.6.7-hotspot", "Machine")
```
*(Ensure the directory path matches the exact folder name inside `C:\Program Files\Eclipse Adoptium\` or `C:\Program Files\OpenJDK\` on your machine).*

### 3. Add `%JAVA_HOME%\bin` to System PATH:
Check via `sysdm.cpl` (System Properties > Advanced > Environment Variables) that either the installer automatically added Java to your System Path, or add:
`%JAVA_HOME%\bin`

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

Modern Java (Java 11+) allows executing single-source Java files directly without manual `.class` compilation!

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
- **Extension Pack for Java** (by Microsoft): Includes language support by Red Hat, debugger for Java, test runner, Maven/Gradle project support, and IntelliCode auto-completion.

---

👉 **Next Step**: Proceed to **[08. WSL2 & Linux Containers](./08-wsl-setup.md)**.
