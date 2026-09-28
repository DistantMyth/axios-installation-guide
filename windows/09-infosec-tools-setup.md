# 09. Infosec & Cybersecurity Tools Setup

Whether you are participating in CTFs (Capture The Flag competitions), taking computer networks or cybersecurity coursework, or learning web application security, having the right toolchain is vital.

Running cybersecurity and penetration testing tools inside **WSL2** is the industry standard for Windows developers: it provides raw Linux socket capabilities, standard POSIX tooling, and sandboxes security tools from your primary host operating system.

---

> [!CAUTION]
> **Legal and Ethical Notice:**
> These tools must only be used on networks, systems, and targets that you own or have explicit, documented permission to test (such as local virtual machines, CTF platforms like Hack The Box / TryHackMe, and college lab sandboxes). Unauthorized scanning or penetration testing against external networks is illegal.

---

## Part 1: Installing CLI Infosec & CTF Tools inside WSL2

Open your **Ubuntu WSL terminal** and install the core toolset:

### 1. Core CTF, Forensics & Steganography Utilities
These are the fundamental utilities used in CTF (Capture The Flag) competitions for metadata extraction, steganography, file carving, and network debugging:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential libimage-exiftool-perl nmap netcat-traditional binwalk steghide pkg-config libssl-dev libudev-dev
```

#### Verify Core CTF Tools inside Ubuntu:
Run these commands inside your WSL terminal to ensure each tool is ready:
```bash
exiftool -ver       # Metadata extraction and image analysis
nmap --version      # Network scanning and port discovery
binwalk --version   # Firmware and binary embedded file analysis / carving
steghide --version  # Steganography hidden data extraction
nc -h               # Netcat networking utility
```

### 2. Extended Networking & Reconnaissance Tools
```bash
sudo apt install -y tcpdump tshark socat dnsutils whois traceroute
```

- **`nmap`**: The world's leading network mapper and port scanner.
  ```bash
  # Quick test against local network gateway or scanme:
  nmap -sV -p 80,443 scanme.nmap.org
  ```
- **`tcpdump` & `tshark`**: Command-line packet sniffers and traffic analyzers.
- **`netcat` (`nc`)**: The "Swiss Army knife" of networking for socket debugging, port listening, and banner grabbing.

### 2. Password Auditing & Cryptography Tools
```bash
sudo apt install -y john hashcat
```
- **`john` (John the Ripper)**: High-performance password cracker and hash analyzer.
- **`hashcat`**: Advanced password recovery tool.

### 3. Web Application Directory Fuzzing
```bash
sudo apt install -y gobuster ffuf
```
- **`gobuster` / `ffuf`**: High-speed brute-force tools for discovering hidden directories, files, DNS subdomains, and virtual hosts on web servers.

### 4. Python Security & Exploit Development (via `uv`)
Inside WSL, use `uv` to build an isolated security virtual environment:

```bash
# Install uv in WSL if not already installed:
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# Create a dedicated security tools directory and virtualenv:
mkdir -p ~/infosec-python && cd ~/infosec-python
uv venv
source .venv/bin/activate

# Install essential Python security libraries:
uv pip install scapy pwntools requests beautifulsoup4 cryptography
```
- **`scapy`**: Powerful interactive packet manipulation and crafting framework.
- **`pwntools`**: Exploit development and CTF automation library for binary exploitation.

---

## Part 2: Windows Native GUI Tools

Certain tools work best with a native Windows graphical user interface:

### 1. Wireshark (Native Packet Analyzer)
Install Wireshark and the Npcap packet capture driver on Windows:
```powershell
winget install WiresharkFoundation.Wireshark
```
*(Or in Admin PowerShell via Chocolatey: `choco install -y wireshark`)*.

### 2. Burp Suite Community Edition (Web Proxy)
Burp Suite is the industry-standard intercepting proxy for analyzing HTTP/HTTPS requests, finding web vulnerabilities, and testing APIs:
```powershell
winget install PortSwigger.BurpSuite.Community
```
*(Or via Chocolatey: `choco install -y burp-suite-free-edition`)*.

---

## 🎯 Recommended Free Practice Platforms
To practice legally and sharpen your skills:
- [OverTheWire (Bandit)](https://overthewire.org/wargames/bandit/): Learn Linux command-line mastery and basic security concepts.
- [PicoCTF](https://picoctf.org/): Beginner-friendly cybersecurity challenges created by Carnegie Mellon University.
- [TryHackMe](https://tryhackme.com/): Guided, interactive cybersecurity labs covering both theory and hands-on testing.

---

👉 **Next Step**: Proceed to **[10. Web3 & Solana Development Setup (inside WSL)](./10-web3-setup.md)**.
