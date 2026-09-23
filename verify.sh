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
MAGENTA='\033[0;35m'
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

# mise (Polyglot Runtime & Tool Manager)
HAS_MISE=false
MISE_BIN=""
if command -v mise >/dev/null 2>&1; then
    HAS_MISE=true
    MISE_BIN="mise"
elif [ -x "$HOME/.local/bin/mise" ]; then
    HAS_MISE=true
    MISE_BIN="$HOME/.local/bin/mise"
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ "$HAS_MISE" = true ]; then
    MISE_VER=$($MISE_BIN --version 2>/dev/null)
    MISE_TOOLS=$($MISE_BIN ls --current 2>/dev/null | tr '\n' ' ' || true)
    if [ -n "$MISE_TOOLS" ]; then
        report_pass "mise (Tool Manager)" "$MISE_VER (Active: $MISE_TOOLS)"
    else
        report_pass "mise (Tool Manager)" "$MISE_VER (Installed)"
    fi
else
    if [ "$OS_TYPE" = "Darwin" ]; then
        report_warn "mise (Tool Manager)" "Optional but recommended: brew install mise (to manage Java, Node, Python)"
    else
        report_warn "mise (Tool Manager)" "Optional but recommended: curl https://mise.run | sh (to manage Java, Node, Python)"
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
    if g++ -std=c++17 "$TEMP_CPP" -o "$TEMP_BIN" >/dev/null 2>&1; then
        report_pass "<bits/stdc++.h> Header" "Compiles cleanly with g++"
    else
        report_fail "<bits/stdc++.h> Header" "Compilation failed! bits/stdc++.h not found by g++"
    fi
    rm -f "$TEMP_CPP" "$TEMP_BIN"

    # Test Policy-Based Data Structure (ordered_set) compilation & execution
    TEMP_PBDS=$(mktemp /tmp/verify_pbds.XXXXXX.cpp)
    TEMP_PBDS_BIN=$(mktemp /tmp/verify_pbds.XXXXXX.out)
    cat << 'EOF' > "$TEMP_PBDS"
#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>

using namespace std;
using namespace __gnu_pbds;

template<class T>
using ordered_set = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;

int main() {
    ordered_set<int> s;
    s.insert(10);
    s.insert(20);
    s.insert(30);
    if (*s.find_by_order(1) == 20 && s.order_of_key(25) == 2) {
        return 0;
    }
    return 1;
}
EOF
    if g++ -std=c++17 "$TEMP_PBDS" -o "$TEMP_PBDS_BIN" >/dev/null 2>&1 && "$TEMP_PBDS_BIN" >/dev/null 2>&1; then
        report_pass "PBDS (ordered_set)" "Compiles and executes correctly with g++"
    else
        report_fail "PBDS (ordered_set)" "ordered_set template failed to compile or run"
    fi
    rm -f "$TEMP_PBDS" "$TEMP_PBDS_BIN"
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
    PY_PATH=$(command -v python3)
    if [[ "$PY_PATH" == *"mise"* ]]; then
        report_pass "Python 3" "$(python3 --version) (Managed by mise)"
    else
        report_pass "Python 3" "$(python3 --version) ($PY_PATH)"
    fi
elif [ "$HAS_MISE" = true ] && $MISE_BIN which python >/dev/null 2>&1; then
    report_warn "Python 3" "Installed in mise, but mise not activated in this shell. Run: eval \"\$($MISE_BIN activate $(basename "$SHELL"))\""
else
    report_fail "Python 3" "Install with: mise use -g python@3.12 (or brew install python / apt install python3)"
fi

if command -v uv >/dev/null 2>&1; then
    report_pass "Astral uv" "$(uv --version)"
else
    report_fail "Astral uv" "Install with: mise use -g uv (or curl -LsSf https://astral.sh/uv/install.sh | sh)"
fi

# ==============================================================================
# 5. Node.js & Node Version Manager (NVM / mise)
# ==============================================================================
header "5. Node.js & Tool Manager (NVM / mise)"

if command -v node >/dev/null 2>&1; then
    NODE_PATH=$(command -v node)
    if [[ "$NODE_PATH" == *"mise"* ]]; then
        report_pass "Node.js" "$(node -v) (Managed by mise)"
    else
        report_pass "Node.js" "$(node -v)"
    fi
elif [ "$HAS_MISE" = true ] && $MISE_BIN which node >/dev/null 2>&1; then
    report_warn "Node.js" "Node.js installed in mise, but mise not activated. Run: eval \"\$($MISE_BIN activate $(basename "$SHELL"))\""
else
    report_fail "Node.js" "Install with: mise use -g node@lts (or nvm install --lts && nvm use --lts)"
fi

if command -v npm >/dev/null 2>&1; then
    report_pass "npm" "v$(npm -v)"
else
    report_fail "npm" "npm not found (Fix with: mise use -g node@lts)"
fi

# NVM or mise detection
NVM_FOUND=false
if [ -n "${NVM_DIR:-}" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    NVM_FOUND=true
elif [ -s "$HOME/.nvm/nvm.sh" ]; then
    NVM_FOUND=true
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh" >/dev/null 2>&1 || true
fi

if [[ "$(command -v node 2>/dev/null)" == *"mise"* ]]; then
    report_pass "Node Version Manager" "Managed via mise ($MISE_VER)"
elif [ "$NVM_FOUND" = true ]; then
    report_pass "NVM (Node Version Manager)" "Configured at ${NVM_DIR}"
elif [ "$HAS_MISE" = true ]; then
    report_pass "Node Version Manager" "mise available for Node management (mise use -g node@lts)"
else
    report_warn "Node Version Manager" "Neither mise nor nvm detected (Install mise: curl https://mise.run | sh)"
fi

# ==============================================================================
# 6. Java Development Kit (JDK 21)
# ==============================================================================
header "6. Java Development Kit (JDK)"

if command -v java >/dev/null 2>&1; then
    JAVA_OUT=$(java -version 2>&1 | head -n 1)
    JAVA_PATH=$(command -v java)
    if [[ "$JAVA_PATH" == *"mise"* ]]; then
        report_pass "Java Runtime" "$JAVA_OUT (Managed by mise)"
    else
        report_pass "Java Runtime" "$JAVA_OUT"
    fi
elif [ "$HAS_MISE" = true ] && $MISE_BIN which java >/dev/null 2>&1; then
    report_warn "Java Runtime" "Java installed in mise, but mise not activated. Run: eval \"\$($MISE_BIN activate $(basename "$SHELL"))\""
else
    report_fail "Java Runtime" "Install with: mise use -g java@21 (or brew install openjdk / apt install openjdk-21-jdk)"
fi

if command -v javac >/dev/null 2>&1; then
    report_pass "Java Compiler (javac)" "$(javac -version 2>&1)"
else
    report_fail "Java Compiler (javac)" "javac not found in PATH (Install with: mise use -g java@21)"
fi

if [ -n "${JAVA_HOME:-}" ] && [ -d "$JAVA_HOME" ]; then
    report_pass "JAVA_HOME Variable" "$JAVA_HOME"
else
    if [ "$HAS_MISE" = true ]; then
        report_warn "JAVA_HOME Variable" "JAVA_HOME not exported in this session. Running 'eval \"\$($MISE_BIN activate $(basename "$SHELL"))\"' exports JAVA_HOME automatically!"
    else
        report_warn "JAVA_HOME Variable" "JAVA_HOME not exported. Install mise ('curl https://mise.run | sh' -> 'mise use -g java@21') to manage JAVA_HOME automatically"
    fi
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
# Summary & Actionable Recommendations
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
    echo -e "${YELLOW}⚠️  Some components are missing or require configuration. See recommended fixes below:${NC}"
fi

if [ "$fail_count" -gt 0 ] || [ "$warn_count" -gt 0 ]; then
    echo ""
    echo -e "${MAGENTA}=================================================================${NC}"
    echo -e "${MAGENTA}         RECOMMENDED SOLUTIONS & QUICK FIXES (via mise)          ${NC}"
    echo -e "${MAGENTA}=================================================================${NC}"

    if [ "$HAS_MISE" != true ]; then
        echo -e " ${WHITE}📦 1. Install mise (Universal Tool & Runtime Manager):${NC}"
        if [ "$OS_TYPE" = "Darwin" ]; then
            echo -e "    ${YELLOW}brew install mise${NC}"
            echo -e "    ${GRAY}echo 'eval \"\$(mise activate zsh)\"' >> ~/.zshrc && source ~/.zshrc${NC}"
        else
            echo -e "    ${YELLOW}curl https://mise.run | sh${NC}"
            echo -e "    ${GRAY}echo 'eval \"\$(~/.local/bin/mise activate bash)\"' >> ~/.bashrc && source ~/.bashrc${NC}"
        fi
        echo ""
    fi

    echo -e " ${WHITE}🛠️  One-Command Fixes for Missing Tools:${NC}"
    if ! command -v java >/dev/null 2>&1 || ! command -v javac >/dev/null 2>&1 || [ -z "${JAVA_HOME:-}" ]; then
        echo -e "    ${CYAN}• Fix Java 21 & JAVA_HOME : ${YELLOW}mise use -g java@21${NC}"
    fi
    if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
        echo -e "    ${CYAN}• Fix Node.js LTS & npm   : ${YELLOW}mise use -g node@lts${NC}"
    fi
    if ! command -v python3 >/dev/null 2>&1; then
        echo -e "    ${CYAN}• Fix Python 3            : ${YELLOW}mise use -g python@3.12${NC}"
    fi
    if ! command -v uv >/dev/null 2>&1; then
        echo -e "    ${CYAN}• Fix Astral uv           : ${YELLOW}mise use -g uv${NC}"
    fi
    if ! command -v g++ >/dev/null 2>&1; then
        if [ "$OS_TYPE" = "Darwin" ]; then
            echo -e "    ${CYAN}• Fix GNU G++ (macOS)     : ${YELLOW}brew install gcc${NC}"
        else
            echo -e "    ${CYAN}• Fix GNU G++ (Linux)     : ${YELLOW}sudo apt install -y build-essential${NC} (or pacman -S base-devel)"
        fi
    fi

    if [ "$HAS_MISE" = true ]; then
        echo ""
        echo -e " ${WHITE}🩺 Diagnose Shell Environment:${NC}"
        echo -e "    ${YELLOW}mise doctor${NC}"
    fi
    echo -e "${MAGENTA}=================================================================${NC}"
fi
echo ""
