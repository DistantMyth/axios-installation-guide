# 07. Java Development Setup

Java is essential for academic computer science courses covering Object-Oriented Programming, Data Structures & Algorithms, and distributed systems.

We will install **OpenJDK 21 (LTS)** on your Linux system.

---

## Step 1: Install OpenJDK 21

Follow the instructions for your distribution family:

### Option A: Debian & Ubuntu-Based (`apt`)
```bash
sudo apt update
sudo apt install -y openjdk-21-jdk
```

### Option B: Arch Linux (`pacman`)
```bash
sudo pacman -S --needed jdk-openjdk
```

### Option C: Fedora & Red Hat-Based (`dnf`)
```bash
sudo dnf install -y java-latest-openjdk-devel
```

---

## Step 2: Configure `JAVA_HOME` Environment Variable

Many build tools (Gradle, Maven) and IDEs expect the `JAVA_HOME` variable to be set.

Add the following dynamic resolution line to your shell configuration file:

```bash
# Detect and export JAVA_HOME automatically
JAVA_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
echo "export JAVA_HOME=\"$JAVA_PATH\"" >> ~/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bashrc

# If you use Zsh, run for ~/.zshrc as well:
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
