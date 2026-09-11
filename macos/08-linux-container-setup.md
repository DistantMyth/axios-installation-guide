# 08. Linux Containers Setup on macOS

Unlike Linux (where containers run directly on the host kernel), macOS uses the **Darwin/XNU** kernel. To run Linux containers, macOS uses a lightweight, optimized virtual machine hypervisor under the hood.

Setting up a container runtime on macOS gives you access to real Linux environments, Linux binary toolchains, databases (PostgreSQL, Redis), and security tools without needing dual-booting.

---

## Choosing Your Container Runtime

You can choose between three excellent container options on macOS:

| Runtime | Best For | Highlights |
| :--- | :--- | :--- |
| **OrbStack** *(Recommended)* | Battery life & speed | Boots in 2 seconds, uses 1/10th the RAM of Docker Desktop, seamless Mac networking. |
| **Docker Desktop** | Official UI & features | Standard enterprise GUI, extensions marketplace, Kubernetes support. |
| **Colima** | CLI purists & open-source | Completely free, open-source, terminal-only background daemon. |

---

## Option A: OrbStack (Recommended for Apple Silicon)

OrbStack is a fast, lightweight Docker Desktop alternative built natively in Swift for macOS:

1. Install via Homebrew:
   ```zsh
   brew install --cask orbstack
   ```
2. Launch **OrbStack** from Spotlight (`Cmd + Space` -> `OrbStack`).
3. Follow the quick one-click initial prompt to enable Docker CLI integration.

---

## Option B: Docker Desktop (Official GUI)

1. Install via Homebrew:
   ```zsh
   brew install --cask docker
   ```
2. Open **Docker** from your Applications folder.
3. Accept the terms of service and start the Docker engine.

---

## Option C: Colima (Lightweight Open Source CLI)

If you prefer a 100% terminal-based, open-source container runtime:

1. Install Colima and Docker CLI via Homebrew:
   ```zsh
   brew install colima docker docker-compose
   ```
2. Start the background container runtime:
   ```zsh
   colima start --cpu 4 --memory 6
   ```

---

## Step 2: Verify Docker CLI

Once your chosen runtime is running, verify that the `docker` command responds in Terminal:

```zsh
docker --version
```

Run the official test container:

```zsh
docker run --rm hello-world
```

You should see:
```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

Containerization is now active on your Mac!

---

👉 **Next Step**: Proceed to **[09. Infosec Tools Setup via Linux Containers](./09-infosec-tools-setup.md)**.
