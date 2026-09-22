# 08. Docker Linux Containers Setup

Docker is the foundation of modern software engineering. It packages applications, dependencies, libraries, and configurations into lightweight, standalone containers that run identically across any machine.

On Linux, containers run **natively on the Linux kernel** with zero virtualization overhead, delivering unmatched performance.

---

## Step 1: Install Docker Engine

Follow the instructions for your distribution:

### Option A: Debian & Ubuntu-Based (`apt`)

Install Docker from the official Docker repository:

```bash
# 1. Add Docker's official GPG key:
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 2. Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 3. Install Docker Engine, CLI, and Docker Compose:
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

*(For pure Debian, replace `ubuntu` with `debian` in the URLs above).*

---

### Option B: Arch Linux (`pacman`)

```bash
sudo pacman -S --needed docker docker-compose
sudo systemctl enable --now docker
```

---

### Option C: Fedora (`dnf`)

```bash
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
```

---

## Step 2: Configure Non-Root Access (Run Docker Without `sudo`)

By default, the Docker daemon binds to a Unix socket owned by `root`. To run Docker commands safely as your regular user:

1. Create the `docker` group (if it doesn't already exist):
   ```bash
   sudo groupadd -f docker
   ```

2. Add your current user to the `docker` group:
   ```bash
   sudo usermod -aG docker $USER
   ```

3. Activate the new group membership immediately:
   ```bash
   newgrp docker
   ```
   *(Or log out and log back in to your Linux desktop session).*

4. Start and enable the Docker daemon:
   ```bash
   sudo systemctl enable --now docker
   ```

---

## Step 3: Verify the Docker Setup

Run the official Docker test container:

```bash
docker run --rm hello-world
```

You should receive this output:
```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

---

## 💡 Quick Tips for College Projects

- **Spin up a database instantly without installing software on your host**:
  ```bash
  # Spin up PostgreSQL in 2 seconds:
  docker run -d --name local-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 postgres
  ```
- **VS Code Dev Containers**:
  Install the **Dev Containers** extension in VS Code. It allows you to open any GitHub repository directly inside a containerized sandbox with all languages and compilers pre-configured!

---

👉 **Next Step**: Proceed to **[09. Infosec Tools Setup](./09-infosec-tools-setup.md)**.
