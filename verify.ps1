<#
.SYNOPSIS
    Comprehensive Developer Environment Verification Script for Windows
.DESCRIPTION
    Checks whether all essential tools, compilers, runtimes, environment variables,
    and configurations for coursework, competitive programming, and development
    are installed and properly configured on Windows.
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\verify.ps1
#>

$ErrorActionPreference = "SilentlyContinue"
$Host.UI.RawUI.WindowTitle = "Developer Environment Verification - Windows"

$passCount = 0
$failCount = 0
$warnCount = 0

function Write-Header {
    param([string]$title)
    Write-Host ""
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "  $title" -ForegroundColor Cyan
    Write-Host "=================================================================" -ForegroundColor Cyan
}

function Report-Pass {
    param([string]$tool, [string]$details)
    Write-Host " [✔ INSTALLED] " -ForegroundColor Green -NoNewline
    Write-Host ("{0,-24}" -f $tool) -ForegroundColor White -NoNewline
    Write-Host " : $details" -ForegroundColor Gray
    $script:passCount++
}

function Report-Fail {
    param([string]$tool, [string]$fix)
    Write-Host " [✘ NOT FOUND] " -ForegroundColor Red -NoNewline
    Write-Host ("{0,-24}" -f $tool) -ForegroundColor White -NoNewline
    Write-Host " : $fix" -ForegroundColor Yellow
    $script:failCount++
}

function Report-Warn {
    param([string]$tool, [string]$message)
    Write-Host " [! ATTENTION] " -ForegroundColor Yellow -NoNewline
    Write-Host ("{0,-24}" -f $tool) -ForegroundColor White -NoNewline
    Write-Host " : $message" -ForegroundColor DarkYellow
    $script:warnCount++
}

Clear-Host
Write-Host "🔍 Starting Windows Developer Environment Verification..." -ForegroundColor Cyan
Write-Host "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor DarkGray

# -------------------------------------------------------------
# 1. Package Managers
# -------------------------------------------------------------
Write-Header "1. Windows Package Managers"

# Chocolatey
$chocoCmd = Get-Command choco -ErrorAction SilentlyContinue
if ($chocoCmd) {
    $chocoVer = (& choco --version 2>$null)
    Report-Pass "Chocolatey (choco)" "Version $chocoVer"
} else {
    Report-Fail "Chocolatey (choco)" "Run install script in Admin PowerShell (see windows/01-chocolatey-setup.md)"
}

# Winget
$wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
if ($wingetCmd) {
    $wingetVer = (& winget --version 2>$null)
    Report-Pass "Windows Package Manager" "Version $wingetVer"
} else {
    Report-Warn "Windows Package Manager" "winget not found (Update 'App Installer' from Microsoft Store)"
}

# -------------------------------------------------------------
# 2. Core Development Tools
# -------------------------------------------------------------
Write-Header "2. Core Development Tools"

# Git
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if ($gitCmd) {
    $gitVer = (& git --version 2>$null)
    Report-Pass "Git" "$gitVer"
} else {
    Report-Fail "Git" "Install with: choco install -y git"
}

# VS Code
$codeCmd = Get-Command code -ErrorAction SilentlyContinue
if ($codeCmd) {
    $codeVer = (& code --version 2>$null | Select-Object -First 1)
    Report-Pass "Visual Studio Code" "Version $codeVer"
} else {
    $codePath = "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe"
    if (Test-Path $codePath) {
        Report-Pass "Visual Studio Code" "Installed (path: $codePath)"
    } else {
        Report-Fail "Visual Studio Code" "Install with: choco install -y vscode"
    }
}

# 7-Zip
$sevenZip = Get-Command 7z, 7zz -ErrorAction SilentlyContinue
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
if ($sevenZip) {
    Report-Pass "7-Zip" "Command $($sevenZip.Name) available in PATH"
} elseif (Test-Path $sevenZipPath) {
    Report-Pass "7-Zip" "Installed at $sevenZipPath"
} else {
    Report-Fail "7-Zip" "Install with: choco install -y 7zip"
}

# Wget
$wgetCmd = Get-Command wget.exe -ErrorAction SilentlyContinue
if ($wgetCmd) {
    Report-Pass "Wget" "wget.exe available in PATH"
} else {
    Report-Warn "Wget" "GNU wget.exe not in PATH (choco install -y wget)"
}

# -------------------------------------------------------------
# 3. C / C++ Compilers & Competitive Programming
# -------------------------------------------------------------
Write-Header "3. C/C++ Compilers & Competitive Programming"

# GCC
$gccCmd = Get-Command gcc -ErrorAction SilentlyContinue
if ($gccCmd) {
    $gccVer = (& gcc --version 2>$null | Select-Object -First 1)
    Report-Pass "GCC (C Compiler)" "$gccVer"
} else {
    Report-Fail "GCC (C Compiler)" "MinGW not found in PATH (Check C:\tools\mingw64\bin in sysdm.cpl)"
}

# G++
$gppCmd = Get-Command g++ -ErrorAction SilentlyContinue
if ($gppCmd) {
    $gppVer = (& g++ --version 2>$null | Select-Object -First 1)
    Report-Pass "G++ (C++ Compiler)" "$gppVer"

    # Test <bits/stdc++.h> compilation
    $tempCpp = [System.IO.Path]::GetTempFileName() + ".cpp"
    $tempExe = [System.IO.Path]::GetTempFileName() + ".exe"
    Set-Content -Path $tempCpp -Value @"
#include <bits/stdc++.h>
int main() { return 0; }
"@
    & g++ $tempCpp -o $tempExe 2>$null
    if (Test-Path $tempExe) {
        Report-Pass "<bits/stdc++.h> Header" "Compiles cleanly with G++"
        Remove-Item $tempExe -Force -ErrorAction SilentlyContinue
    } else {
        Report-Fail "<bits/stdc++.h> Header" "Failed to compile test file with bits/stdc++.h"
    }
    Remove-Item $tempCpp -Force -ErrorAction SilentlyContinue
} else {
    Report-Fail "G++ (C++ Compiler)" "Install with: choco install -y mingw"
}

# GDB
$gdbCmd = Get-Command gdb -ErrorAction SilentlyContinue
if ($gdbCmd) {
    $gdbVer = (& gdb --version 2>$null | Select-Object -First 1)
    Report-Pass "GDB (Debugger)" "$gdbVer"
} else {
    Report-Warn "GDB (Debugger)" "GDB not found in PATH (part of mingw)"
}

# -------------------------------------------------------------
# 4. Python Ecosystem & uv
# -------------------------------------------------------------
Write-Header "4. Python Ecosystem & Astral uv"

# Python
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pythonCmd) {
    # Check for Microsoft Store redirector alias
    if ($pythonCmd.Source -like "*WindowsApps*") {
        Report-Fail "Python" "Intercepted by WindowsApps! Disable 'App execution aliases' in Windows Settings"
    } else {
        $pyVer = (& python --version 2>$null)
        Report-Pass "Python 3" "$pyVer ($($pythonCmd.Source))"
    }
} else {
    Report-Fail "Python 3" "Install with: choco install -y python3"
}

# uv
$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
if ($uvCmd) {
    $uvVer = (& uv --version 2>$null)
    Report-Pass "Astral uv" "$uvVer"
} else {
    Report-Fail "Astral uv" "Install with: winget install --id=astral-sh.uv -e"
}

# -------------------------------------------------------------
# 5. JavaScript / Node.js Ecosystem & NVM
# -------------------------------------------------------------
Write-Header "5. Node.js & Node Version Manager (NVM)"

# NVM
$nvmCmd = Get-Command nvm -ErrorAction SilentlyContinue
if ($nvmCmd) {
    $nvmVer = (& nvm version 2>$null)
    Report-Pass "nvm-windows" "Version $nvmVer"
} else {
    Report-Fail "nvm-windows" "Install with: winget install CoreyButler.NVMforWindows (or choco install nvm)"
}

# Node.js
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if ($nodeCmd) {
    $nodeVer = (& node -v 2>$null)
    Report-Pass "Node.js" "Active version: $nodeVer"
} else {
    Report-Fail "Node.js" "Run: nvm install lts; nvm use lts"
}

# npm
$npmCmd = Get-Command npm -ErrorAction SilentlyContinue
if ($npmCmd) {
    $npmVer = (& npm -v 2>$null)
    Report-Pass "npm" "Version $npmVer"
} else {
    Report-Fail "npm" "Missing npm executable"
}

# -------------------------------------------------------------
# 6. Java Development Kit (JDK 21)
# -------------------------------------------------------------
Write-Header "6. Java Development Kit (JDK)"

# Java Runtime
$javaCmd = Get-Command java -ErrorAction SilentlyContinue
if ($javaCmd) {
    $javaVer = (& java -version 2>&1 | Select-Object -First 1)
    Report-Pass "Java Runtime" "$javaVer"
} else {
    Report-Fail "Java Runtime" "Install with: winget install EclipseAdoptium.Temurin.21.JDK (or choco install openjdk)"
}

# Java Compiler
$javacCmd = Get-Command javac -ErrorAction SilentlyContinue
if ($javacCmd) {
    $javacVer = (& javac -version 2>&1 | Select-Object -First 1)
    Report-Pass "Java Compiler (javac)" "$javacVer"
} else {
    Report-Fail "Java Compiler" "javac not found in PATH"
}

# JAVA_HOME
if ($env:JAVA_HOME -and (Test-Path $env:JAVA_HOME)) {
    Report-Pass "JAVA_HOME Variable" "Configured -> $env:JAVA_HOME"
} else {
    Report-Warn "JAVA_HOME Variable" "JAVA_HOME is not set or directory does not exist (see windows/07-java-setup.md)"
}

# -------------------------------------------------------------
# 7. Git Identity & GitHub SSH Connection
# -------------------------------------------------------------
Write-Header "7. Git Configuration & GitHub SSH"

$gitName = (& git config --global user.name 2>$null)
$gitEmail = (& git config --global user.email 2>$null)

if ($gitName) {
    Report-Pass "Git user.name" "$gitName"
} else {
    Report-Fail "Git user.name" "Configure with: git config --global user.name 'Your Name'"
}

if ($gitEmail) {
    Report-Pass "Git user.email" "$gitEmail"
} else {
    Report-Fail "Git user.email" "Configure with: git config --global user.email 'your_email@example.com'"
}

# SSH Key file
$sshKeyPath = "$HOME\.ssh\id_ed25519"
$sshRsaPath = "$HOME\.ssh\id_rsa"
if ((Test-Path $sshKeyPath) -or (Test-Path $sshRsaPath)) {
    Report-Pass "SSH Key Pair" "Found local SSH key file in $HOME\.ssh\"
} else {
    Report-Fail "SSH Key Pair" "No SSH key found. Generate with: ssh-keygen -t ed25519 -C 'email'"
}

# Test SSH connection to GitHub
$sshTest = (& ssh -T -o StrictHostKeyChecking=accept-new -o ConnectTimeout=5 git@github.com 2>&1)
if ($sshTest -like "*successfully authenticated*") {
    Report-Pass "GitHub SSH Link" "Authenticated successfully with GitHub!"
} else {
    Report-Warn "GitHub SSH Link" "Could not verify SSH auth (Add public key to GitHub > Settings > SSH keys)"
}

# -------------------------------------------------------------
# 8. WSL & Virtualization Containers
# -------------------------------------------------------------
Write-Header "8. WSL & Containers"

$wslCmd = Get-Command wsl -ErrorAction SilentlyContinue
if ($wslCmd) {
    $wslStatus = (& wsl --status 2>$null | Out-String)
    if ($wslStatus -like "*Default Distribution*") {
        Report-Pass "WSL2 Subsystem" "Configured & Default Linux distro active"
    } else {
        $wslList = (& wsl -l -q 2>$null)
        if ($wslList) {
            Report-Pass "WSL2 Subsystem" "Installed with distributions: $($wslList -join ', ')"
        } else {
            Report-Warn "WSL2 Subsystem" "WSL installed but no distro found (Run: wsl --install -d Ubuntu)"
        }
    }
} else {
    Report-Warn "WSL2 Subsystem" "WSL not installed (Run: wsl --install -d Ubuntu in Admin PowerShell)"
}

$dockerCmd = Get-Command docker -ErrorAction SilentlyContinue
if ($dockerCmd) {
    $dockerVer = (& docker --version 2>$null)
    Report-Pass "Docker Engine" "$dockerVer"
} else {
    Report-Warn "Docker Engine" "Docker Desktop not found (optional, see windows/08-wsl-setup.md)"
}

# -------------------------------------------------------------
# Summary
# -------------------------------------------------------------
Write-Host ""
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                      VERIFICATION SUMMARY                       " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  Passed / Configured  : " -NoNewline; Write-Host "$passCount" -ForegroundColor Green
Write-Host "  Missing / Action req : " -NoNewline; Write-Host "$failCount" -ForegroundColor Red
Write-Host "  Warnings / Optional  : " -NoNewline; Write-Host "$warnCount" -ForegroundColor Yellow
Write-Host "=================================================================" -ForegroundColor Cyan

if ($failCount -eq 0) {
    Write-Host "🎉 Outstanding! Your Windows developer environment is 100% configured!" -ForegroundColor Green
} else {
    Write-Host "⚠️  Please check the items marked [✘ NOT FOUND] above and follow their setup guide." -ForegroundColor Yellow
}
Write-Host ""
