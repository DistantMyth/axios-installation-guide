# 07. Java Development Setup

Java is a core language for university coursework in Object-Oriented Programming (OOP), Data Structures & Algorithms (DSA), and software architecture.

We will install **OpenJDK 21 (LTS)** on macOS using Homebrew and register it with macOS's native Java Virtual Machine system.

---

## Step 1: Install OpenJDK 21 via Homebrew

In your Terminal, run:

```zsh
brew install openjdk
```

*(Alternatively, you can install Eclipse Temurin via `brew install --cask temurin`)*.

---

## Step 2: Symlink OpenJDK into macOS JVM Registry

For macOS's built-in system Java wrappers (`/usr/libexec/java_home`) and IDEs to recognize Homebrew's OpenJDK installation, create a symbolic link:

```zsh
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```
*(Enter your Mac password when prompted).*

---

## Step 3: Configure `JAVA_HOME` in `~/.zshrc`

Add `JAVA_HOME` and update your PATH so command-line tools (Maven, Gradle) immediately recognize Java:

```zsh
cat << 'EOF' >> ~/.zshrc

# Java Configuration
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"
EOF

source ~/.zshrc
```

---

## Step 4: Verify Java Version

In your Terminal, verify that both the runtime and compiler respond:

```zsh
java -version
javac -version
```

You should see:
```text
openjdk version "21.0.x" ...
OpenJDK Runtime Environment Homebrew ...
OpenJDK 64-Bit Server VM ...
```

---

## Step 5: Quick Single-File Compilation Test

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
