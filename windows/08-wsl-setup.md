# 08. WSL2 & Linux Containers Setup

Windows Subsystem for Linux (**WSL2**) allows you to run a genuine Linux environment—including the Linux kernel, command-line utilities, package managers, and server daemons—directly inside Windows without the overhead of traditional virtual machines.

Having a real Linux environment on Windows is essential for operating systems labs, system programming, backend development, cybersecurity tools, and container workflows.

---

## Step 1: Enable Hardware Virtualization in BIOS/UEFI

Before installing WSL2, verify that hardware virtualization is enabled:
1. Press `Ctrl + Shift + Esc` to open **Task Manager**.
2. Click the **Performance** tab and select **CPU**.
3. In the bottom right corner, check **Virtualization**: it must state **Enabled**.
   *(If disabled, reboot your PC, enter your BIOS/UEFI settings by pressing F2/F12/Del, and enable Intel VT-x or AMD-V / SVM).*

---

## Step 2: Install WSL2 with Ubuntu

1. Open **PowerShell as Administrator**.
2. Run the one-command WSL installer:
   ```powershell
   wsl --install -d Ubuntu
   ```
3. This command enables the Virtual Machine Platform feature, downloads the latest Linux kernel update, and installs **Ubuntu LTS**.
4. **Reboot your computer** when prompted to finish enabling the Windows virtualization hypervisor.

---

## Step 3: Initial Ubuntu Configuration

1. After your PC restarts, an Ubuntu terminal window will open automatically (or launch **Ubuntu** from your Start Menu).
2. Wait a minute for the initial filesystem setup.
3. You will be prompted to create a **UNIX username** and **password**:
   - Username: choose your preferred lowercase username (e.g. `john`).
   - Password: type a secure password (note: characters will not appear on screen while typing UNIX passwords).

![WSL Terminal Verification](../images/wsl.png)

4. Update your new Ubuntu system:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

---

## Step 4: Connect VS Code to WSL2

Developing inside WSL2 using the VS Code interface on Windows is a superpower:

1. Open VS Code on Windows.
2. Open the Extensions sidebar (`Ctrl + Shift + X`), search for **WSL** (by Microsoft), and click **Install**.
3. Open your Ubuntu terminal and navigate to your home directory:
   ```bash
   mkdir -p ~/projects/hello-wsl
   cd ~/projects/hello-wsl
   code .
   ```
4. The first time you run `code .`, it will download the VS Code Server inside WSL. A VS Code window will pop up with `[WSL: Ubuntu]` displayed in the bottom-left status bar!

> [!TIP]
> **Performance Golden Rule**: Always store your programming projects and git repositories inside the Linux home directory (`~/projects/` or `/home/<username>/`), **not** inside `/mnt/c/Users/...`. File access speed across the Windows-to-Linux translation layer is significantly slower than native Linux ext4 filesystem access!

---

## Step 5: (Optional) Docker Desktop with WSL2 Backend

If you want to run Docker containers with a graphical dashboard:
1. Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/).
2. During setup, ensure **"Use the WSL 2 based engine"** is checked.
3. In Docker Desktop Settings > **Resources** > **WSL Integration**, enable your Ubuntu distribution.
4. Now you can run `docker` commands directly from both PowerShell and your Ubuntu WSL terminal!

---

👉 **Next Step**: Proceed to **[09. Infosec Tools Setup](./09-infosec-tools-setup.md)**.
