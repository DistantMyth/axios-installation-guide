# 07. Java Development Setup

Java is a core language for university coursework in Object-Oriented Programming (OOP), Data Structures & Algorithms (DSA), and software architecture.

You have two great options to install and manage Java on macOS:
- **Option A (Recommended for Managing Multiple JDKs):** Use **`mise`**, a fast, Rust-based tool manager that downloads any certified OpenJDK version on demand and automatically configures `JAVA_HOME` without manual symlinks.
- **Option B (Homebrew System JVM):** Install OpenJDK 21 directly via Homebrew and symlink it into the macOS system JVM registry.

---

## Option A: `mise` — Modern JDK & Tool Manager (Recommended)

[mise](https://mise.jdx.dev/) is an extremely fast, modern tool manager (replacing `asdf` and `sdkman`) that allows seamless switching between Java versions without permission or JVM registry hassles.

### 1. Install `mise` via Homebrew:
```zsh
brew install mise
```

### 2. Activate `mise` in Zsh:
Add the activation line to your `~/.zshrc`:

```zsh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Install & Select Java 21 LTS:
```zsh
mise use --global java@21
```
`mise` automatically downloads certified Eclipse Temurin OpenJDK 21, configures executables, and manages `JAVA_HOME` dynamically!

### 4. Useful `mise` Commands:
- **List installed Java versions**: `mise ls java`
- **List all available Java versions**: `mise ls-remote java`
- **Install an older version (e.g., Java 17 for an older project)**:
  ```zsh
  mise install java@17
  ```
- **Switch version inside a specific project folder**:
  ```zsh
  mise use java@17
  ```
  *(Creates a `.mise.toml` file in that folder; navigating to that directory automatically switches your active JDK and `JAVA_HOME`).*

---

## Option B: Homebrew System OpenJDK 21

If you prefer installing OpenJDK system-wide into the macOS JVM registry:

### 1. Install OpenJDK 21 via Homebrew:
```zsh
brew install openjdk
```
*(Alternatively, you can install Eclipse Temurin via `brew install --cask temurin`)*.

### 2. Symlink OpenJDK into macOS JVM Registry:
For macOS's built-in system Java wrappers (`/usr/libexec/java_home`) and IDEs to recognize Homebrew's OpenJDK installation, create a symbolic link:

```zsh
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```
*(Enter your Mac password when prompted).*

### 3. Configure `JAVA_HOME` in `~/.zshrc`:
```zsh
cat << 'EOF' >> ~/.zshrc

# Java Configuration
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"
EOF

source ~/.zshrc
```

---

## Step 3: Verify Java Version

In your Terminal, verify that both the runtime and compiler respond:

```zsh
java -version
javac -version
```

You should see:
```text
openjdk version "21.0.x" ...
OpenJDK Runtime Environment ...
OpenJDK 64-Bit Server VM ...
```

---

## Step 4: Quick Single-File Compilation Test

Verify single-file execution:

```zsh
cat << 'EOF' > Hello.java
public class Hello {
    public static void main(String[] args) {
        System.out.println("☕ Java " + System.getProperty("java.version") + " is running smoothly on macOS!");
    }
}
EOF

java Hello.java
```

If it prints `☕ Java 21... is running smoothly on macOS!`, your Java environment is complete! Clean up the test file:
```zsh
rm -f Hello.java
```

---

👉 **Next Step**: Proceed to **[08. Linux Containers Setup](./08-linux-container-setup.md)**.
