# 09. Infosec & Cybersecurity Tools Setup (via Linux Containers)

For macOS developers, the gold standard for cybersecurity, CTF challenges, and penetration testing is running tools inside an **isolated Linux container**.

---

> [!CAUTION]
> **Ethical & Legal Responsibility:**
> Security analysis and port scanning must only be performed on networks, virtual machines, and systems that you explicitly own or have written authorization to evaluate. Testing unauthorized targets is illegal.

---

## 💡 Why Use a Linux Container on macOS for Infosec?

1. **Raw Sockets & Packet Crafting**: Low-level networking tools (e.g. Nmap OS fingerprinting `-O`, SYN stealth scans `-sS`, Scapy packet injection) rely on Linux raw socket architectures (`AF_PACKET`) that macOS restricts.
2. **Binary Exploitation & CTF Reverse Engineering**: Tools like `gdb` with PEDA/GEF, `pwntools`, and decompilers target Linux ELF binaries. macOS uses the Mach-O binary format and enforces System Integrity Protection (SIP), making local binary analysis difficult on macOS.
3. **Safe Sandboxing**: Prevents security tools, scripts, and wordlists from triggering macOS Gatekeeper warnings or polluting system libraries.

---

## Step 1: Create a Persistent Infosec Linux Container

We will launch an official **Kali Linux** (or Ubuntu) container with a shared folder mapped to your Mac's home directory.

1. On your Mac, create a dedicated workspace folder:
   ```zsh
   mkdir -p ~/infosec-workspace
   ```

2. Run the container using Docker (ensure OrbStack, Docker Desktop, or Colima is running):
   ```zsh
   docker run -it --name infosec-lab \
     --network host \
     -v ~/infosec-workspace:/workspace \
     -w /workspace \
     kalilinux/kali-rolling /bin/bash
   ```
   *(On Apple Silicon Macs, Docker will seamlessly run the ARM64 image or emulate x86 via Rosetta 2).*

---

## Step 2: Install Core Security Tools Inside the Container

Now inside the `infosec-lab` container prompt (`root@...:/workspace#`), update and install the standard security suite:

```bash
apt update
apt install -y \
  nmap \
  tcpdump \
  tshark \
  netcat-openbsd \
  socat \
  dnsutils \
  whois \
  traceroute \
  john \
  hashcat \
  gobuster \
  ffuf \
  curl \
  wget \
  git \
  python3 \
  python3-pip \
  python3-venv
```

---

## Step 3: Python Security & Exploit Lab (via `uv`)

Set up a fast Python security environment inside the container:

```bash
# Install uv inside the container:
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# Create virtual environment in the shared workspace:
cd /workspace
uv venv
source .venv/bin/activate

# Install pentest & CTF exploit development libraries:
uv pip install scapy pwntools requests beautifulsoup4 cryptography
```

---

## Step 4: Daily Workflow & Reconnecting to Your Lab

- **To exit the container**:
  Type `exit` or press `Ctrl + D`.

- **To reconnect to your container anytime from your Mac Terminal**:
  ```zsh
  docker start -ai infosec-lab
  ```

- **Seamless File Sharing**:
  Any files, scripts, CTF challenges, or wordlists you save in `~/infosec-workspace` on your Mac are instantly accessible inside `/workspace` in the container, and vice versa! You can edit code in VS Code on macOS and run it inside the Linux container.

---

## Native macOS GUI Tools (Burp Suite & Wireshark)

While CLI network reconnaissance and binary exploitation belong in the Linux container, GUI web proxying and packet inspection work well as native macOS applications:

### 1. Burp Suite Community Edition (Native Mac App)
```zsh
brew install --cask burp-suite
```

### 2. Wireshark (Native Mac App)
```zsh
brew install --cask wireshark
```

---

👉 **macOS Setup is Complete!** You have a robust UNIX developer workstation with full Linux container capability for security and coursework.
