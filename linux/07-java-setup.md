# 07. Java Development Setup

Java is essential for academic computer science courses covering Object-Oriented Programming, Data Structures & Algorithms, and distributed systems.

You have two options to install and manage Java on Linux:
- **Option A (Recommended for Multi-Version Workflows):** Use **`mise`**, a modern, blazing-fast polyglot runtime manager that installs any certified OpenJDK version on demand and automatically manages `JAVA_HOME`.
- **Option B (System Package Manager):** Install OpenJDK 21 LTS directly via your Linux distribution's package manager (`apt`, `pacman`, or `dnf`).

---

## Option A: `mise` — Modern JDK & Tool Manager (Recommended)

[mise](https://mise.jdx.dev/) is an extremely fast, Rust-based tool manager (the modern alternative to `asdf` and `sdkman`) that allows seamless switching between Java versions without root permissions or distro conflicts.

### 1. Install `mise`:
```bash
curl https://mise.run | sh
```

### 2. Activate `mise` in Your Shell:
Add the activation line to your shell configuration file:

```bash
# If using Bash (Ubuntu, Debian, Fedora):
echo 'eval "$($HOME/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# If using Zsh (Manjaro, Kali, Arch with zsh):
if [ -f ~/.zshrc ]; then
  echo 'eval "$($HOME/.local/bin/mise activate zsh)"' >> ~/.zshrc
  source ~/.zshrc
fi
```

### 3. Install & Select Java 21 LTS:
```bash
mise use --global java@21
```
`mise` downloads certified Eclipse Temurin OpenJDK 21, configures executables, and automatically sets `JAVA_HOME`!

### 4. Useful `mise` Commands:
- **List installed Java versions**: `mise ls java`
- **List all available Java versions**: `mise ls-remote java`
- **Install an older version (e.g., Java 17 for an older project)**:
  ```bash
  mise install java@17
  ```
- **Switch version inside a specific project folder**:
  ```bash
  mise use java@17
  ```
  *(Creates a `.mise.toml` file in that folder; navigating to that directory automatically switches your active JDK and `JAVA_HOME`).*

---

## Option B: Distro Package Managers (`apt`, `pacman`, `dnf`)

If you prefer a single system-wide installation via your distribution:

### 1. Install OpenJDK 21:
- **Debian / Ubuntu-Based (`apt`)**:
  ```bash
  sudo apt update
  sudo apt install -y openjdk-21-jdk
  ```
- **Arch Linux (`pacman`)**:
  ```bash
  sudo pacman -S --needed jdk-openjdk
  ```
- **Fedora & Red Hat-Based (`dnf`)**:
  ```bash
  sudo dnf install -y java-latest-openjdk-devel
  ```

### 2. Configure `JAVA_HOME` Environment Variable:
Add dynamic resolution to your shell configuration file:

```bash
# Detect and export JAVA_HOME automatically
JAVA_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
echo "export JAVA_HOME=\"$JAVA_PATH\"" >> ~/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bashrc

if [ -f ~/.zshrc ]; then
  echo "export JAVA_HOME=\"$JAVA_PATH\"" >> ~/.zshrc
  echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
fi

source ~/.bashrc
```

---

## Step 3: Verify Java Version

Run in your terminal:

```bash
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

```bash
cat << 'EOF' > Hello.java
public class Hello {
    public static void main(String[] args) {
        System.out.println("☕ Java " + System.getProperty("java.version") + " is running smoothly on Linux!");
    }
}
EOF

java Hello.java
```

If it prints `☕ Java 21... is running smoothly on Linux!`, Java is ready! Clean up the test file:
```bash
rm -f Hello.java
```

---

👉 **Next Step**: Proceed to **[08. Docker Containers Setup](./08-linux-container-setup.md)**.
