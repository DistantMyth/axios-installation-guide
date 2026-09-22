#!/usr/bin/env bash
# ==============================================================================
# Comprehensive Developer Environment Verification Script for macOS (& Linux)
# ==============================================================================
# Usage:
#   chmod +x verify.sh && ./verify.sh
# ==============================================================================

set -u

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

pass_count=0
fail_count=0
warn_count=0

header() {
    echo ""
    echo -e "${CYAN}=================================================================${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}=================================================================${NC}"
}

report_pass() {
    local tool="$1"
    local details="$2"
    printf " ${GREEN}[✔ INSTALLED]${NC} %-25s : ${GRAY}%s${NC}\n" "$tool" "$details"
    pass_count=$((pass_count + 1))
}

report_fail() {
    local tool="$1"
    local fix="$2"
    printf " ${RED}[✘ NOT FOUND]${NC} %-25s : ${YELLOW}%s${NC}\n" "$tool" "$fix"
    fail_count=$((fail_count + 1))
}

report_warn() {
    local tool="$1"
    local message="$2"
    printf " ${YELLOW}[! ATTENTION]${NC} %-25s : ${WHITE}%s${NC}\n" "$tool" "$message"
    warn_count=$((warn_count + 1))
}

OS_TYPE="$(uname -s)"
ARCH_TYPE="$(uname -m)"

echo -e "${CYAN}🔍 Starting Developer Environment Verification...${NC}"
echo -e "${GRAY}OS: ${OS_TYPE} | Architecture: ${ARCH_TYPE} | Date: $(date)${NC}"

# ==============================================================================
# 1. Package Managers
# ==============================================================================
if [ "$OS_TYPE" = "Darwin" ]; then
    header "1. macOS Package Manager (Homebrew)"

    if command -v brew >/dev/null 2>&1; then
        BREW_VER=$(brew --version | head -n 1)
        report_pass "Homebrew (brew)" "$BREW_VER"

        # Check Apple Silicon PATH
        if [ "$ARCH_TYPE" = "arm64" ]; then
            if [[ ":$PATH:" == *":/opt/homebrew/bin:"* ]]; then
                report_pass "Apple Silicon PATH" "/opt/homebrew/bin is in PATH"
            else
                report_fail "Apple Silicon PATH" "Add 'eval \"\$(/opt/homebrew/bin/brew shellenv)\"' to ~/.zprofile"
            fi
        fi
    else
        report_fail "Homebrew (brew)" "Install via /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    fi
else
    header "1. Linux Package Management"
    if command -v apt >/dev/null 2>&1; then
        report_pass "Package Manager (APT)" "Debian/Ubuntu family detected"
    elif command -v pacman >/dev/null 2>&1; then
        report_pass "Package Manager (Pacman)" "Arch Linux family detected"
    elif command -v dnf >/dev/null 2>&1; then
        report_pass "Package Manager (DNF)" "Fedora/RHEL family detected"
    fi
fi

# ==============================================================================
# 2. Core Development Tools
# ==============================================================================
header "2. Core Development Tools"

# Git
if command -v git >/dev/null 2>&1; then
    GIT_VER=$(git --version)
    GIT_LOC=$(command -v git)
    if [ "$OS_TYPE" = "Darwin" ] && [ "$GIT_LOC" = "/usr/bin/git" ]; then
        report_warn "Git" "$GIT_VER (Using macOS system git; recommend 'brew install git')"
    else
        report_pass "Git" "$GIT_VER ($GIT_LOC)"
    fi
else
    report_fail "Git" "Install via package manager (brew install git / apt install git)"
fi

# VS Code
if command -v code >/dev/null 2>&1; then
    CODE_VER=$(code --version 2>/dev/null | head -n 1)
    report_pass "Visual Studio Code" "CLI 'code' available (v$CODE_VER)"
elif [ -d "/Applications/Visual Studio Code.app" ]; then
    report_pass "Visual Studio Code" "Installed in /Applications (CLI not in PATH; run 'Shell Command: Install code in PATH' in VS Code)"
else
    report_fail "Visual Studio Code" "Install via package manager (brew install --cask visual-studio-code)"
fi

# 7-Zip
if command -v 7zz >/dev/null 2>&1; then
    report_pass "7-Zip (7zz)" "Modern 7-Zip command available"
elif command -v 7z >/dev/null 2>&1; then
    report_pass "7-Zip (7z)" "7-Zip command available"
else
    report_fail "7-Zip" "Install via brew install sevenzip (or apt install 7zip)"
fi

# Wget
if command -v wget >/dev/null 2>&1; then
    report_pass "GNU Wget" "$(wget --version | head -n 1)"
else
    report_warn "GNU Wget" "wget not found (brew install wget / apt install wget)"
fi

# Curl
if command -v curl >/dev/null 2>&1; then
    report_pass "cURL" "$(curl --version | head -n 1)"
else
    report_fail "cURL" "curl is required"
fi

# ==============================================================================
# 3. C / C++ Compilers & Competitive Programming
# ==============================================================================
header "3. C/C++ Compilers & Competitive Programming"

# Check G++ & Apple Clang vs GNU GCC
if command -v g++ >/dev/null 2>&1; then
    GPP_RAW=$(g++ --version 2>&1 | head -n 1)
    GPP_PATH=$(command -v g++)

    if [ "$OS_TYPE" = "Darwin" ]; then
        if echo "$GPP_RAW" | grep -qi "clang"; then
            report_fail "G++ (GNU GCC)" "g++ is Apple Clang! Needs GNU GCC symlink in ~/.local/bin (see macos/03-compilers-setup.md)"
        else
            report_pass "G++ (GNU GCC)" "$GPP_RAW ($GPP_PATH)"
        fi
    else
        report_pass "G++ Compiler" "$GPP_RAW"
    fi

    # Test <bits/stdc++.h> compilation
    TEMP_CPP=$(mktemp /tmp/verify_bits.XXXXXX.cpp)
    TEMP_BIN=$(mktemp /tmp/verify_bits.XXXXXX.out)
    cat << 'EOF' > "$TEMP_CPP"
#include <bits/stdc++.h>
int main() { return 0; }
EOF
    if g++ "$TEMP_CPP" -o "$TEMP_BIN" >/dev/null 2>&1; then
        report_pass "<bits/stdc++.h> Header" "Compiles cleanly with g++"
    else
        report_fail "<bits/stdc++.h> Header" "Compilation failed! bits/stdc++.h not found by g++"
    fi
    rm -f "$TEMP_CPP" "$TEMP_BIN"
else
    report_fail "G++ (C++ Compiler)" "Install genuine GCC (brew install gcc / apt install build-essential)"
fi

# Debugger (GDB on Linux, GDB/LLDB on Mac)
if command -v gdb >/dev/null 2>&1; then
    report_pass "GDB Debugger" "$(gdb --version | head -n 1)"
elif command -v lldb >/dev/null 2>&1; then
    report_pass "LLDB Debugger" "$(lldb --version | head -n 1)"
else
    report_warn "Debugger" "Neither gdb nor lldb found"
fi

# ==============================================================================
# 4. Python Ecosystem & Astral uv
# ==============================================================================
header "4. Python Ecosystem & Astral uv"

if command -v python3 >/dev/null 2>&1; then
    report_pass "Python 3" "$(python3 --version)"
else
    report_fail "Python 3" "Install via brew install python / apt install python3"
fi

if command -v uv >/dev/null 2>&1; then
    report_pass "Astral uv" "$(uv --version)"
else
    report_fail "Astral uv" "Install via brew install uv (or curl -LsSf https://astral.sh/uv/install.sh | sh)"
fi

# ==============================================================================
# 5. Node.js & Node Version Manager (NVM)
# ==============================================================================
header "5. Node.js & Node Version Manager (NVM)"

# NVM is a shell function, so check NVM_DIR or function
NVM_FOUND=false
if [ -n "${NVM_DIR:-}" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    NVM_FOUND=true
elif [ -s "$HOME/.nvm/nvm.sh" ]; then
    NVM_FOUND=true
    export NVM_DIR="$HOME/.nvm"
    # Source nvm for this session
    \. "$NVM_DIR/nvm.sh" >/dev/null 2>&1 || true
fi

if [ "$NVM_FOUND" = true ]; then
    report_pass "NVM (Node Version Manager)" "Configured at ${NVM_DIR}"
else
    report_fail "NVM" "NVM not loaded. Run install script (see 05-nvm-setup.md)"
fi

if command -v node >/dev/null 2>&1; then
    report_pass "Node.js" "$(node -v)"
else
    report_fail "Node.js" "Node executable not active (Run: nvm install --lts && nvm use --lts)"
fi

if command -v npm >/dev/null 2>&1; then
    report_pass "npm" "v$(npm -v)"
else
    report_fail "npm" "npm not found"
fi

# ==============================================================================
# 6. Java Development Kit (JDK 21)
# ==============================================================================
header "6. Java Development Kit (JDK)"

if command -v java >/dev/null 2>&1; then
    JAVA_OUT=$(java -version 2>&1 | head -n 1)
    report_pass "Java Runtime" "$JAVA_OUT"
else
    report_fail "Java Runtime" "Install OpenJDK 21 (brew install openjdk / apt install openjdk-21-jdk)"
fi

if command -v javac >/dev/null 2>&1; then
    report_pass "Java Compiler (javac)" "$(javac -version 2>&1)"
else
    report_fail "Java Compiler (javac)" "javac not found in PATH"
fi

if [ -n "${JAVA_HOME:-}" ] && [ -d "$JAVA_HOME" ]; then
    report_pass "JAVA_HOME Variable" "$JAVA_HOME"
else
    report_warn "JAVA_HOME Variable" "JAVA_HOME not exported in shell profile (see 07-java-setup.md)"
fi

# ==============================================================================
# 7. Git Identity & GitHub SSH Connection
# ==============================================================================
header "7. Git Configuration & GitHub SSH"

GIT_NAME=$(git config --global user.name 2>/dev/null || true)
GIT_EMAIL=$(git config --global user.email 2>/dev/null || true)

if [ -n "$GIT_NAME" ]; then
    report_pass "Git user.name" "$GIT_NAME"
else
    report_fail "Git user.name" "Configure with: git config --global user.name 'Your Name'"
fi

if [ -n "$GIT_EMAIL" ]; then
    report_pass "Git user.email" "$GIT_EMAIL"
else
    report_fail "Git user.email" "Configure with: git config --global user.email 'your_email@example.com'"
fi

# SSH Key file
if [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]; then
    report_pass "SSH Key Pair" "Found key file in $HOME/.ssh/"
else
    report_fail "SSH Key Pair" "No SSH key found. Generate with: ssh-keygen -t ed25519 -C 'email'"
fi

# Test GitHub SSH Auth
SSH_TEST=$(ssh -T -o StrictHostKeyChecking=accept-new -o ConnectTimeout=5 git@github.com 2>&1 || true)
if echo "$SSH_TEST" | grep -qi "successfully authenticated"; then
    report_pass "GitHub SSH Link" "Authenticated successfully with GitHub!"
else
    report_warn "GitHub SSH Link" "Could not verify SSH auth (Add public key to GitHub > Settings > SSH keys)"
fi

# ==============================================================================
# 8. Containers & Infosec Environment
# ==============================================================================
header "8. Containers & Infosec Environment"

if command -v docker >/dev/null 2>&1; then
    DOCKER_VER=$(docker --version)
    if docker info >/dev/null 2>&1; then
        report_pass "Docker Engine" "$DOCKER_VER (Daemon responsive)"
    else
        report_warn "Docker Engine" "$DOCKER_VER (Daemon not running; start OrbStack/Docker Desktop)"
    fi
else
    report_warn "Docker Engine" "Docker not installed (brew install --cask orbstack / docker)"
fi

if [ "$OS_TYPE" = "Darwin" ]; then
    # Check infosec container setup
    if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
        if docker ps -a --format '{{.Names}}' 2>/dev/null | grep -q "infosec-lab"; then
            report_pass "Infosec Container" "Container 'infosec-lab' exists and ready"
        else
            report_warn "Infosec Container" "Container 'infosec-lab' not created yet (see macos/09-infosec-tools-setup.md)"
        fi
    fi

    if [ -d "$HOME/infosec-workspace" ]; then
        report_pass "Infosec Workspace" "~/infosec-workspace exists"
    else
        report_warn "Infosec Workspace" "~/infosec-workspace not created (mkdir -p ~/infosec-workspace)"
    fi
fi

# ==============================================================================
# Summary
# ==============================================================================
echo ""
echo -e "${CYAN}=================================================================${NC}"
echo -e "${CYAN}                      VERIFICATION SUMMARY                       ${NC}"
echo -e "${CYAN}=================================================================${NC}"
printf "  Passed / Configured  : ${GREEN}%d${NC}\n" "$pass_count"
printf "  Missing / Action req : ${RED}%d${NC}\n" "$fail_count"
printf "  Warnings / Optional  : ${YELLOW}%d${NC}\n" "$warn_count"
echo -e "${CYAN}=================================================================${NC}"

if [ "$fail_count" -eq 0 ]; then
    echo -e "${GREEN}🎉 Outstanding! Your developer environment is 100% configured!${NC}"
else
    echo -e "${YELLOW}⚠️  Please check the items marked [✘ NOT FOUND] above and follow their respective setup guide.${NC}"
fi
echo ""
