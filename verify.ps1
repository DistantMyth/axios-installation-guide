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
# 3. C / C++ Compilers (MSYS2 UCRT64) & CP Verification
# -------------------------------------------------------------
Write-Header "3. C/C++ Compilers (MSYS2 UCRT64) & CP Verification"

# MSYS2 & Pacman
$pacmanCmd = Get-Command pacman -ErrorAction SilentlyContinue
if ($pacmanCmd) {
    $pacmanVer = (& pacman --version 2>$null | Select-Object -First 1)
    Report-Pass "MSYS2 (pacman)" "$pacmanVer ($($pacmanCmd.Source))"
} elseif (Test-Path "C:\msys64\usr\bin\pacman.exe") {
    Report-Pass "MSYS2 Platform" "Installed at C:\msys64 (Tip: add C:\msys64\usr\bin to PATH for direct pacman commands)"
} elseif (Test-Path "C:\msys32\usr\bin\pacman.exe") {
    Report-Pass "MSYS2 Platform" "Installed at C:\msys32 (Tip: add C:\msys32\usr\bin to PATH for direct pacman commands)"
} else {
    Report-Warn "MSYS2 (pacman)" "MSYS2 not detected in PATH (see windows/05-compilers-and-path.md)"
}

# GCC
$gccCmd = Get-Command gcc -ErrorAction SilentlyContinue
if ($gccCmd) {
    $gccVer = (& gcc --version 2>$null | Select-Object -First 1)
    Report-Pass "GCC (C Compiler)" "$gccVer ($($gccCmd.Source))"
} else {
    Report-Fail "GCC (C Compiler)" "GCC not found in PATH (Add C:\msys64\ucrt64\bin to top of User PATH)"
}

# G++
$gppCmd = Get-Command g++ -ErrorAction SilentlyContinue
if ($gppCmd) {
    $gppVer = (& g++ --version 2>$null | Select-Object -First 1)
    Report-Pass "G++ (C++ Compiler)" "$gppVer ($($gppCmd.Source))"

    # Test 1: <bits/stdc++.h> compilation
    $tempCpp = [System.IO.Path]::GetTempFileName() + ".cpp"
    $tempExe = [System.IO.Path]::GetTempFileName() + ".exe"
    Set-Content -Path $tempCpp -Value @"
#include <bits/stdc++.h>
int main() { return 0; }
"@
    & g++ -std=c++17 $tempCpp -o $tempExe 2>$null
    if (Test-Path $tempExe) {
        Report-Pass "<bits/stdc++.h> Header" "Compiles cleanly with G++"
        Remove-Item $tempExe -Force -ErrorAction SilentlyContinue
    } else {
        Report-Fail "<bits/stdc++.h> Header" "Failed to compile test file with bits/stdc++.h"
    }
    Remove-Item $tempCpp -Force -ErrorAction SilentlyContinue

    # Test 2: Policy-Based Data Structure (ordered_set) compilation & execution
    $tempPbds = [System.IO.Path]::GetTempFileName() + ".cpp"
    $tempPbdsExe = [System.IO.Path]::GetTempFileName() + ".exe"
    Set-Content -Path $tempPbds -Value @"
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
"@
    & g++ -std=c++17 $tempPbds -o $tempPbdsExe 2>$null
    if (Test-Path $tempPbdsExe) {
        & $tempPbdsExe 2>$null
        if ($LASTEXITCODE -eq 0) {
            Report-Pass "PBDS (ordered_set)" "Compiles and executes correctly with G++"
        } else {
            Report-Fail "PBDS (ordered_set)" "Compiled but returned incorrect result"
        }
        Remove-Item $tempPbdsExe -Force -ErrorAction SilentlyContinue
    } else {
        Report-Fail "PBDS (ordered_set)" "ordered_set template failed to compile! Use MSYS2 UCRT64 toolchain (see windows/05-compilers-and-path.md)"
    }
    Remove-Item $tempPbds -Force -ErrorAction SilentlyContinue
} else {
    Report-Fail "G++ (C++ Compiler)" "Install via MSYS2: winget install MSYS2.MSYS2 then pacman -S --noconfirm mingw-w64-ucrt-x86_64-toolchain"
}

# GDB
$gdbCmd = Get-Command gdb -ErrorAction SilentlyContinue
if ($gdbCmd) {
    $gdbVer = (& gdb --version 2>$null | Select-Object -First 1)
    Report-Pass "GDB (Debugger)" "$gdbVer"
} else {
    Report-Warn "GDB (Debugger)" "GDB not found in PATH (included in mingw-w64-ucrt-x86_64-toolchain)"
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
# 6. Java Development Kit (JDK 21) & mise
# -------------------------------------------------------------
Write-Header "6. Java Development Kit (JDK) & mise"

# Check mise for Java
$miseCmd = Get-Command mise -ErrorAction SilentlyContinue
$miseInstalled = $false
if ($miseCmd) {
    $miseInstalled = $true
    $miseVer = (& mise --version 2>$null)
    Report-Pass "mise (Tool & JDK Manager)" "$miseVer ($($miseCmd.Source))"

    # Verify Java via mise
    $miseJavaCur = (& mise current java 2>$null)
    $miseJavaList = (& mise ls java 2>$null)
    if ($miseJavaCur) {
        Report-Pass "Java via mise" "Active version: java@$miseJavaCur"
    } elseif ($miseJavaList) {
        Report-Warn "Java via mise" "Java installed in mise ($miseJavaList) but no global version selected. Solution: mise use --global java@21"
    } else {
        Report-Warn "Java via mise" "No Java installed via mise. Solution: mise use --global java@21"
    }
} else {
    Report-Warn "mise (JDK Manager)" "mise not detected. Recommended solution for Java: winget install jdx.mise"
}

# Java Runtime
$javaCmd = Get-Command java -ErrorAction SilentlyContinue
if ($javaCmd) {
    $javaVer = (& java -version 2>&1 | Select-Object -First 1)
    Report-Pass "Java Runtime" "$javaVer ($($javaCmd.Source))"
} else {
    if ($miseInstalled) {
        Report-Fail "Java Runtime" "java not found in PATH! Solution: run 'mise use --global java@21' and ensure mise is in your `$PROFILE"
    } else {
        Report-Fail "Java Runtime" "java not found! Solution: install mise ('winget install jdx.mise') then run 'mise use --global java@21'"
    }
}

# Java Compiler
$javacCmd = Get-Command javac -ErrorAction SilentlyContinue
if ($javacCmd) {
    $javacVer = (& javac -version 2>&1 | Select-Object -First 1)
    Report-Pass "Java Compiler (javac)" "$javacVer ($($javacCmd.Source))"
} else {
    if ($miseInstalled) {
        Report-Fail "Java Compiler (javac)" "javac not found in PATH! Solution: run 'mise use --global java@21' (mise automatically includes javac)"
    } else {
        Report-Fail "Java Compiler (javac)" "javac not found! Solution: install mise ('winget install jdx.mise') then run 'mise use --global java@21'"
    }
}

# JAVA_HOME
if ($env:JAVA_HOME -and (Test-Path $env:JAVA_HOME)) {
    Report-Pass "JAVA_HOME Variable" "Configured -> $env:JAVA_HOME"
} else {
    if ($miseInstalled) {
        Report-Warn "JAVA_HOME Variable" "JAVA_HOME is not set! Solution: add mise activation to `$PROFILE: Add-Content `$PROFILE '`nmise activate ps1 | Out-String | Invoke-Expression' and run 'mise use -g java@21'"
    } else {
        Report-Warn "JAVA_HOME Variable" "JAVA_HOME not set! Solution: install mise ('winget install jdx.mise') and run 'mise use -g java@21' (mise sets JAVA_HOME automatically)"
    }
}

# Java Execution Smoke Test
if ($javaCmd -and $javacCmd) {
    $tempJavaDir = [System.IO.Path]::GetTempPath()
    $tempJava = [System.IO.Path]::Combine($tempJavaDir, "VerifyJavaTest.java")
    $tempClass = [System.IO.Path]::Combine($tempJavaDir, "VerifyJavaTest.class")
    Set-Content -Path $tempJava -Value @"
public class VerifyJavaTest {
    public static void main(String[] args) {
        System.out.println("JAVA_OK");
    }
}
"@
    & javac $tempJava 2>$null
    if (Test-Path $tempClass) {
        $runOut = (& java -cp $tempJavaDir VerifyJavaTest 2>$null)
        if ($runOut -match "JAVA_OK") {
            Report-Pass "Java Execution Test" "Single-file compilation and JVM execution successful"
        } else {
            Report-Fail "Java Execution Test" "Compiled test class but JVM execution failed"
        }
        Remove-Item $tempClass -Force -ErrorAction SilentlyContinue
    } else {
        Report-Fail "Java Execution Test" "javac failed to compile test class"
    }
    Remove-Item $tempJava -Force -ErrorAction SilentlyContinue
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
