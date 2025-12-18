# Docker Engine Installer for Ubuntu (WSL-friendly)

Automates a clean, official Docker Engine setup on Ubuntu (including WSL Ubuntu) using Docker’s APT repository. It removes conflicting packages, configures the Docker GPG key and repository, installs core components, and adds your user to the `docker` group so you can run `docker` without `sudo`.

> Script: `install-docker.sh`

---

## What This Script Does

- Removes conflicting or legacy packages: `docker.io`, `docker-doc`, `docker-compose`, `docker-compose-v2`, `podman-docker`, `containerd`, `runc`.
- Adds Docker’s official APT repository and GPG key under `/etc/apt/keyrings/docker.gpg`.
- Installs: `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-buildx-plugin`, `docker-compose-plugin`.
- Creates the `docker` group (if not present) and adds the current user to it.
- Applies the new group in the current shell via `newgrp docker`.
- Skips everything if `docker` is already installed (`command -v docker`).

## Supported Environments

- Ubuntu LTS releases (tested commonly on 20.04/22.04/24.04).
- WSL 2 (Ubuntu on Windows) with optional systemd support.
- Standard Ubuntu VMs or bare-metal machines using `apt`.

## Prerequisites

- `sudo` privileges.
- Internet access to reach `download.docker.com`.
- On WSL, systemd is recommended for managing the Docker service (see notes below).

## Quick Start

```bash
# From within Ubuntu/WSL Ubuntu
cd wsl-ubuntu/developer-tools/docker
chmod +x install-docker.sh
./install-docker.sh
```

Post-install:

```bash
# Verify you can run docker without sudo
docker version

# Pull and run the test image
docker run --rm hello-world
```

If you still see a permissions error, log out and back in (or restart your terminal/session) so the new group membership takes effect.

## How It Works (Step-by-Step)

1. Checks whether `docker` exists in `PATH`. If found, exits without changes.
2. Removes legacy/conflicting packages to avoid partial or mixed installs.
3. Installs support packages: `ca-certificates`, `curl`, `gnupg`.
4. Adds Docker’s GPG key to `/etc/apt/keyrings/docker.gpg` with correct permissions.
5. Adds Docker’s APT repository using your architecture and Ubuntu codename:
   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
   https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
   | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```
6. Installs Docker Engine and plugins from the official repo.
7. Creates the `docker` group and adds the current `$USER` to it.
8. Executes `newgrp docker` to apply group changes in the current session.

## WSL Notes

- Enable systemd in WSL for proper service management:
  1. Edit `/etc/wsl.conf` in your WSL distro:
     ```ini
     [boot]
     systemd=true
     ```
  2. From Windows PowerShell (not inside WSL):
     ```powershell
     wsl --shutdown
     ```
  3. Reopen Ubuntu and confirm systemd is active:
     ```bash
     systemctl is-system-running
     ```
- Docker Desktop vs. native engine: avoid running both simultaneously in the same WSL distro. This script installs the native engine inside Ubuntu.

## Uninstall / Cleanup

To fully remove Docker Engine and its data:

```bash
sudo systemctl stop docker || true
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/keyrings/docker.gpg
sudo apt-get autoremove -y --purge
sudo rm -rf /var/lib/docker /var/lib/containerd
```

Note: Removing `/var/lib/docker` permanently deletes images, containers, and volumes.

## Troubleshooting

- Permission denied when running `docker`:
  - Ensure you are in the `docker` group: `id -nG | grep -q docker || echo "Not in docker group"`
  - Log out and back in, or start a new shell session.

- Cannot connect to the Docker daemon:
  - On systemd-enabled systems (including WSL with systemd):
    ```bash
    sudo systemctl enable --now docker
    systemctl status docker
    ```
  - On WSL without systemd, consider enabling systemd (recommended), or start the daemon manually in advanced setups.

- Repository/Key errors:
  - Confirm the key exists and is readable: `/etc/apt/keyrings/docker.gpg`
  - Re-run: `sudo apt-get update` and watch for errors mentioning `download.docker.com`.

- Group already exists error:
  - Harmless if shown; the `docker` group may already exist from a prior install.

## Security Considerations

- The Docker APT key is stored under `/etc/apt/keyrings/docker.gpg` and used specifically for the Docker repo entry.
- Adding your user to the `docker` group allows root-equivalent operations through the Docker daemon; ensure your user is trusted.

## Why Not `docker.io` from Ubuntu?

- `docker.io` is the Ubuntu-packaged variant and may lag behind upstream. This script uses the official Docker repository for timely updates and features.

## References

- Official docs: Install Docker Engine on Ubuntu — https://docs.docker.com/engine/install/ubuntu/
- Post-install steps: https://docs.docker.com/engine/install/linux-postinstall/
- WSL + systemd: https://learn.microsoft.com/windows/wsl/wsl-config#systemd-support

## License

This folder follows the repository’s license. See the root [LICENSE](../../../LICENSE).
