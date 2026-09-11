# 09. Infosec & Cybersecurity Tools Setup

Linux is the native operating system of choice for cybersecurity researchers, penetration testers, and CTF competitors.

---

> [!CAUTION]
> **Ethical & Legal Responsibility:**
> Security analysis and port scanning must only be performed on networks, virtual machines, and systems that you explicitly own or have written authorization to evaluate. Testing on unauthorized systems is strictly illegal.

---

## 1. Network Reconnaissance & Analysis Tools

Install Nmap, Wireshark/TShark, Netcat, and packet capture tools:

### On Debian / Ubuntu:
```bash
sudo apt update
sudo apt install -y nmap tcpdump tshark wireshark netcat-openbsd socat dnsutils whois traceroute
```

### On Arch Linux:
```bash
sudo pacman -S --needed nmap tcpdump wireshark-cli wireshark-qt openbsd-netcat socat bind-tools whois traceroute
```

### On Fedora:
```bash
sudo dnf install -y nmap tcpdump wireshark wireshark-cli nc socat bind-utils whois traceroute
```

---

## 2. Configure Wireshark for Non-Root Packet Capture (Crucial!)

> [!WARNING]
> **Never run GUI Wireshark as `root` or with `sudo`!**
> Running large graphical applications with millions of lines of protocol dissection code as `root` is a major security vulnerability. Instead, configure the `wireshark` group so standard users can capture packets:

```bash
# 1. On Ubuntu/Debian, if prompted "Should non-superusers be able to capture packets?", select YES.
# If you need to reconfigure:
sudo dpkg-reconfigure wireshark-common

# 2. Add your user to the wireshark group:
sudo usermod -aG wireshark $USER

# 3. Grant capture capabilities to dumpcap:
sudo chmod 750 /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# 4. Activate group in your current session:
newgrp wireshark
```

Now you can launch `wireshark` as a normal user and capture network packets without sudo!

---

## 3. Password Auditing & Hash Cracking

```bash
# Ubuntu / Debian:
sudo apt install -y john hashcat

# Arch Linux:
sudo pacman -S --needed john hashcat

# Fedora:
sudo dnf install -y john hashcat
```

---

## 4. Web Application Fuzzing & Directory Discovery

Install `gobuster` or `ffuf`:
```bash
# Ubuntu / Debian:
sudo apt install -y gobuster ffuf

# Arch Linux:
sudo pacman -S --needed gobuster ffuf

# Fedora:
sudo dnf install -y gobuster ffuf
```

---

## 5. Burp Suite Community Edition (Web Vulnerability Proxy)

Burp Suite Community is the essential proxy for intercepting and inspecting HTTP/HTTPS traffic.

1. Download the Linux 64-bit installer script from the official PortSwigger website:
   [portswigger.net/burp/communitydownload](https://portswigger.net/burp/communitydownload)
2. In your terminal, navigate to your `Downloads` directory and make it executable:
   ```bash
   cd ~/Downloads
   chmod +x burpsuite_community_linux_*.sh
   ./burpsuite_community_linux_*.sh
   ```
3. Follow the graphical setup wizard. It will automatically create a desktop icon and application launcher.

---

## 6. Python Security & Exploit Development Environment (via `uv`)

Set up a dedicated sandbox for Python security tooling:

```bash
mkdir -p ~/security-lab && cd ~/security-lab
uv venv
source .venv/bin/activate

# Install essential pentest & exploit development libraries:
uv pip install scapy pwntools requests beautifulsoup4 cryptography
```

- Test Scapy packet crafting:
  ```bash
  python -c "from scapy.all import IP, ICMP; pkt = IP(dst='8.8.8.8')/ICMP(); print(pkt.summary())"
  ```

---

👉 **Linux Setup is Complete!** Your Linux development and security workstation is now fully operational.
