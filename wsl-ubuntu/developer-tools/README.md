# Developer Tools Installation Script

> **Automate your Linux development environment setup with a single command**

A comprehensive, idempotent installer for Ubuntu/Debian systems that bootstraps a production-ready development environment. Designed for developers who value consistency, automation, and clean installations across WSL2 and native Linux environments.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Install](#quick-install)
  - [Local Installation](#local-installation)
  - [Remote Installation](#remote-installation)
- [Usage](#usage)
  - [Command-Line Flags](#command-line-flags)
  - [Common Use Cases](#common-use-cases)
- [Components](#components)
  - [Core Packages (Always Installed)](#core-packages-always-installed)
  - [Optional Components](#optional-components)
- [Execution Flow](#execution-flow)
- [Post-Installation](#post-installation)
  - [Verification Steps](#verification-steps)
  - [Environment Configuration](#environment-configuration)
- [Advanced Configuration](#advanced-configuration)
  - [Corporate Proxy Support](#corporate-proxy-support)
  - [WSL2-Specific Configuration](#wsl2-specific-configuration)
- [Troubleshooting](#troubleshooting)
- [Architecture](#architecture)
- [Development](#development)
- [FAQ](#faq)
- [License](#license)

---

## Overview

This installation script provides a **batteries-included development environment** by orchestrating the installation of essential CLI tools, language runtimes, and DevOps platforms. Built with modularity in mind, each component can be selectively installed based on your project requirements.

### Key Design Principles

- **Idempotent**: Safe to run multiple times without side effects
- **Modular**: Install only the components you need
- **Opinionated**: Curated toolset based on industry best practices
- **Transparent**: Clear progress indicators and verbose logging
- **Lightweight**: Minimal dependencies, clean installations

### Features

✅ **Automated system updates** and package management  
✅ **Modular installation** with granular control via CLI flags  
✅ **Multiple environment support** (WSL2, Ubuntu, Debian)  
✅ **Enterprise-ready** with proxy and certificate handling  
✅ **Post-install verification** with comprehensive checklist  
✅ **Zero login noise** via `.hushlogin` configuration  
✅ **Integration support** for Jenkins + Maven/Gradle auto-configuration

---

## Prerequisites

### System Requirements

| Requirement | Minimum | Recommended |
|------------|---------|-------------|
| **OS** | Ubuntu 20.04+ / Debian 11+ | Ubuntu 22.04 LTS |
| **Architecture** | x86_64 / amd64 | x86_64 / amd64 |
| **RAM** | 2 GB | 4 GB+ |
| **Disk Space** | 5 GB free | 10 GB+ free |
| **Network** | Internet connectivity | Broadband (for faster downloads) |

### User Permissions

- `sudo` privileges required
- User must be in the `sudoers` file
- Recommended: Run as a non-root user with sudo access

### Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Ubuntu 22.04 LTS | ✅ Fully Supported | Primary development platform |
| Ubuntu 20.04 LTS | ✅ Supported | Tested and verified |
| Debian 11+ | ✅ Supported | APT-based systems |
| WSL2 (Ubuntu) | ✅ Fully Supported | Recommended for Windows users |
| WSL2 (Debian) | ✅ Supported | Requires manual Docker service start |

---

## Installation

### Quick Install

Install everything with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash -s -- --all
```

### Local Installation

Clone the repository and run locally:

```bash
# Clone the repository
git clone https://github.com/adautomendes/toolbox.git
cd toolbox/wsl-ubuntu/developer-tools

# Make the script executable
chmod +x install-developer-tools.sh

# Run with desired flags
./install-developer-tools.sh --all
```

### Remote Installation

Execute directly from GitHub without cloning:

```bash
# Install specific components
curl -fsSL https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash -s -- --nodejs --docker --osh

# With proxy support
curl -fsSL https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash -s -- --all --insecure
```

---

## Usage

### Command-Line Flags

#### Tool Selection Flags

| Flag | Component | Description | Dependencies |
|------|-----------|-------------|--------------|
| `--osh` | Oh My Bash | Enhanced Bash with themes, aliases, and git integration | None |
| `--java21` | Java 21 LTS | JDK 21 + Maven + Gradle | None |
| `--python` | Python Tools | virtualenv and pip tooling | python3 (pre-installed) |
| `--nodejs` | Node.js LTS | NVM + latest LTS Node.js + npm/npx | curl |
| `--docker` | Docker Engine | Docker CE + Docker Compose | None |
| `--kubectl` | Kubernetes CLI | kubectl for K8s cluster management | None |
| `--helm` | Helm | Kubernetes package manager | kubectl (recommended) |
| `--jenkins` | Jenkins LTS | CI/CD server with web UI | Java 11+ (auto-installed) |
| `--all` | All Components | Installs all available tools | None |

#### Configuration Flags

| Flag | Purpose | Use Case |
|------|---------|----------|
| `--insecure` | Disable SSL certificate verification | Corporate proxies, self-signed certificates |

### Command Syntax

```bash
./install-developer-tools.sh [FLAGS]

# Examples:
./install-developer-tools.sh --nodejs --docker
./install-developer-tools.sh --java21 --jenkins --osh
./install-developer-tools.sh --all --insecure
```

### Common Use Cases

#### Web Development Stack

```bash
./install-developer-tools.sh --nodejs --docker --osh
```

**Installs**: Node.js (via NVM), Docker, Oh My Bash  
**Use for**: React, Vue, Angular, Node.js backend development

#### Java/Spring Boot Development

```bash
./install-developer-tools.sh --java21 --docker --jenkins --osh
```

**Installs**: JDK 21, Maven, Gradle, Docker, Jenkins, Oh My Bash  
**Use for**: Spring Boot, microservices, CI/CD pipelines  
**Bonus**: Automatically configures Maven/Gradle in Jenkins

#### Python Data Science

```bash
./install-developer-tools.sh --python --docker --osh
```

**Installs**: Python virtualenv, Docker, Oh My Bash  
**Use for**: Data analysis, ML/AI development, Jupyter notebooks

#### DevOps/SRE Toolkit

```bash
./install-developer-tools.sh --docker --kubectl --helm --jenkins --osh
```

**Installs**: Docker, kubectl, Helm, Jenkins, Oh My Bash  
**Use for**: Kubernetes deployments, infrastructure automation, CI/CD

#### Minimal Setup (Core Tools Only)

```bash
./install-developer-tools.sh
```

**Installs**: Core packages only (see [Core Packages](#core-packages-always-installed))  
**Use for**: Basic Linux development environment

---

## Components

### Core Packages (Always Installed)

The following packages are installed automatically on every execution, regardless of flags:

| Package | Version | Purpose |
|---------|---------|---------|
| `snapd` | Latest | Snap package manager for containerized apps |
| `curl` | Latest | HTTP client for downloading resources |
| `tree` | Latest | Directory structure visualization |
| `yq` | Latest | YAML processor and query tool |
| `jq` | Latest | JSON processor and query tool |
| `git` | Latest | Version control system |
| `wget` | Latest | Network downloader |
| `build-essential` | Latest | Compilation tools (gcc, g++, make) |
| `python3` | Latest | Python 3 interpreter |
| `python3-pip` | Latest | Python package installer |
| `unzip` | Latest | Archive extraction utility |

### Optional Components

#### Oh My Bash (`--osh`)

**Enhanced Bash shell experience with productivity features**

- **Installation Location**: `~/.oh-my-bash/`
- **Configuration**: `~/.bashrc` (automatically modified)
- **Features**:
  - Pre-configured themes (powerline, agnoster, etc.)
  - Git status integration in prompt
  - Auto-completion for common commands
  - Custom aliases and functions
  - Plugin system for extensibility

**Related Documentation**: [oh-my-bash/README.md](oh-my-bash/README.md)

#### Java 21 (`--java21`)

**Complete Java development environment with build tools**

- **Components Installed**:
  - OpenJDK 21 (LTS release)
  - Apache Maven (latest stable)
  - Gradle (latest stable)

- **Installation Paths**:
  - JDK: `/usr/lib/jvm/java-21-openjdk-amd64/`
  - Maven: `~/.m2/` (local repository)
  - Gradle: `~/.gradle/` (cache and config)

- **Environment Variables**:
  ```bash
  JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
  PATH=$JAVA_HOME/bin:$PATH
  ```

- **Integration**: When combined with `--jenkins`, Maven and Gradle are automatically configured in Jenkins

**Related Documentation**: [java/README.md](java/README.md)

#### Python Tools (`--python`)

**Python virtual environment and package management**

- **Components Installed**:
  - `virtualenv` (isolated Python environments)
  - Latest `pip` (Python package installer)

- **Usage Example**:
  ```bash
  # Create a virtual environment
  virtualenv venv
  
  # Activate it
  source venv/bin/activate
  
  # Install packages
  pip install numpy pandas matplotlib
  ```

**Related Documentation**: [python/README.md](python/README.md)

#### Node.js (`--nodejs`)

**Node.js runtime via NVM (Node Version Manager)**

- **Components Installed**:
  - NVM (Node Version Manager)
  - Node.js LTS (latest long-term support version)
  - npm (Node Package Manager)
  - npx (Node Package Execute)

- **Installation Paths**:
  - NVM: `~/.nvm/`
  - Node.js: `~/.nvm/versions/node/vX.X.X/`

- **Environment Variables**:
  ```bash
  NVM_DIR="$HOME/.nvm"
  ```

- **Version Management**:
  ```bash
  # List installed versions
  nvm list
  
  # Install specific version
  nvm install 18.20.0
  
  # Switch versions
  nvm use 20
  ```

**Related Documentation**: [nodejs/README.md](nodejs/README.md)

#### Docker (`--docker`)

**Container runtime and orchestration**

- **Components Installed**:
  - Docker Engine (CE)
  - Docker CLI
  - Docker Compose (if available)

- **Configuration**:
  - Current user added to `docker` group (rootless access)
  - systemd service configured (requires manual start on WSL2)

- **Post-Install Setup**:
  ```bash
  # Start Docker service (WSL2)
  sudo service docker start
  
  # Verify installation
  docker run hello-world
  
  # Check version
  docker --version
  docker compose version
  ```

**Related Documentation**: [docker/README.md](docker/README.md)

#### Kubectl (`--kubectl`)

**Kubernetes command-line interface**

- **Components Installed**:
  - kubectl (latest stable)

- **Configuration**:
  - Installed to `/usr/local/bin/kubectl`
  - Requires `~/.kube/config` for cluster access

- **Verification**:
  ```bash
  kubectl version --client
  kubectl cluster-info
  ```

**Related Documentation**: [kubectl/README.md](kubectl/README.md)

#### Helm (`--helm`)

**Kubernetes package manager**

- **Components Installed**:
  - Helm CLI (latest stable)

- **Installation Path**: `/usr/local/bin/helm`

- **Usage Example**:
  ```bash
  # Add a chart repository
  helm repo add stable https://charts.helm.sh/stable
  
  # Search for charts
  helm search repo nginx
  
  # Install a chart
  helm install my-release stable/nginx
  ```

**Related Documentation**: [helm/README.md](helm/README.md)

#### Jenkins (`--jenkins`)

**Open-source automation server for CI/CD**

- **Components Installed**:
  - Jenkins LTS (Long-Term Support)
  - Java 11+ (dependency, auto-installed if missing)

- **Configuration**:
  - Service: `jenkins`
  - Port: `8080`
  - Home Directory: `/var/lib/jenkins`
  - Initial Admin Password: `/var/lib/jenkins/secrets/initialAdminPassword`

- **Service Management**:
  ```bash
  # Start Jenkins
  sudo systemctl start jenkins
  
  # Enable auto-start on boot
  sudo systemctl enable jenkins
  
  # Check status
  sudo systemctl status jenkins
  
  # View logs
  sudo journalctl -u jenkins -f
  ```

- **First-Time Setup**:
  ```bash
  # Retrieve initial admin password
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  
  # Access web UI
  # http://localhost:8080
  ```

- **Maven/Gradle Integration**: When installed with `--java21`, Maven and Gradle are automatically configured as Global Tools in Jenkins

**Related Documentation**: [jenkins/README.md](jenkins/README.md)

---

## Post-Installation

### Verification Steps

After installation completes, verify your environment with these commands:

#### Core Tools

```bash
# Git
git --version
# Expected: git version 2.x.x

# Python
python3 --version
pip3 --version
# Expected: Python 3.x.x, pip 2x.x.x

# Build tools
gcc --version
make --version
# Expected: gcc (Ubuntu x.x.x) x.x.x, GNU Make x.x
```

#### Node.js (if `--nodejs` was used)

```bash
# Load NVM
source ~/.bashrc

# Verify NVM
nvm --version
# Expected: 0.x.x

# Verify Node.js
node --version
npm --version
npx --version
# Expected: v20.x.x (LTS), 10.x.x, 10.x.x

# List installed versions
nvm list
```

#### Java (if `--java21` was used)

```bash
# Verify Java
java -version
javac -version
# Expected: openjdk version "21.x.x"

# Verify Maven
mvn --version
# Expected: Apache Maven 3.x.x

# Verify Gradle
gradle --version
# Expected: Gradle 8.x

# Check JAVA_HOME
echo $JAVA_HOME
# Expected: /usr/lib/jvm/java-21-openjdk-amd64
```

#### Docker (if `--docker` was used)

```bash
# Start Docker service (WSL2 only)
sudo service docker start

# Verify Docker
docker --version
docker compose version
# Expected: Docker version 24.x.x, Docker Compose version v2.x.x

# Test Docker
docker run hello-world
# Expected: "Hello from Docker!" message

# Check Docker group membership
groups
# Expected: ... docker ...
```

#### Kubernetes Tools (if `--kubectl` or `--helm` were used)

```bash
# Verify kubectl
kubectl version --client
# Expected: Client Version: v1.x.x

# Verify Helm
helm version
# Expected: version.BuildInfo{Version:"v3.x.x"}
```

#### Jenkins (if `--jenkins` was used)

```bash
# Check Jenkins service status
sudo systemctl status jenkins
# Expected: active (running)

# Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# Copy this password for web UI setup

# Access Jenkins Web UI
# Open browser: http://localhost:8080
```

### Environment Configuration

#### Shell Configuration

After installation, reload your shell configuration:

```bash
# Reload Bash configuration
source ~/.bashrc

# Or restart your terminal
# Close and reopen your terminal window
```

#### Environment Variables

Verify critical environment variables are set:

```bash
# Display all relevant environment variables
env | grep -E 'JAVA_HOME|NVM_DIR|PATH'

# Example expected output:
# JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
# NVM_DIR=/home/user/.nvm
# PATH=...:/usr/local/bin:...
```

#### Docker Group Permission (if Docker was installed)

If you encounter permission errors with Docker:

```bash
# Verify you're in the docker group
groups

# If 'docker' is not listed, you may need to log out and log back in
# Or force group membership update:
newgrp docker

# Test Docker without sudo
docker ps
```

---

## Advanced Configuration

### Corporate Proxy Support

For environments behind corporate proxies or with SSL/TLS interception:

#### Using the `--insecure` Flag

```bash
# Install with SSL verification disabled
./install-developer-tools.sh --all --insecure
```

**What `--insecure` does**:
- Adds `--insecure` flag to all `curl` commands
- Passes through to Oh My Bash installer
- Passes through to Node.js/NVM installer

#### Setting Proxy Environment Variables

```bash
# Set proxy variables before running the script
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080
export no_proxy=localhost,127.0.0.1,.company.com

# Run the installer
./install-developer-tools.sh --all
```

#### APT Proxy Configuration

Create or edit `/etc/apt/apt.conf.d/proxy.conf`:

```bash
sudo tee /etc/apt/apt.conf.d/proxy.conf > /dev/null << EOF
Acquire::http::Proxy "http://proxy.company.com:8080";
Acquire::https::Proxy "http://proxy.company.com:8080";
EOF
```

#### Docker Proxy Configuration

If using Docker behind a proxy:

```bash
# Create Docker daemon config
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf > /dev/null << EOF
[Service]
Environment="HTTP_PROXY=http://proxy.company.com:8080"
Environment="HTTPS_PROXY=http://proxy.company.com:8080"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF

# Reload and restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### WSL2-Specific Configuration

#### Docker Service Auto-Start

Docker doesn't auto-start on WSL2. Add to `~/.bashrc`:

```bash
# Auto-start Docker on WSL2
if ! service docker status > /dev/null 2>&1; then
    sudo service docker start > /dev/null 2>&1
fi
```

#### Systemd Support (WSL 2.0+)

For WSL 2.0 with systemd support, enable it in `/etc/wsl.conf`:

```ini
[boot]
systemd=true
```

Then restart WSL:

```powershell
# In PowerShell (Windows)
wsl --shutdown
wsl
```

#### Memory Limits

Configure WSL2 memory limits in `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
memory=8GB
processors=4
swap=2GB
```

#### File System Performance

For better file system performance, work within WSL's native file system (`/home/`) rather than Windows mounts (`/mnt/c/`).

---

## Troubleshooting

### Common Issues and Solutions

#### Permission Denied Errors

**Problem**: Script fails with permission errors

```bash
# Solution: Make script executable
chmod +x install-developer-tools.sh

# Run with proper permissions
./install-developer-tools.sh --all
```

#### APT Package Issues

**Problem**: `apt` cannot locate packages or fails to download

```bash
# Solution: Update package cache
sudo apt update

# If still failing, try refreshing sources
sudo apt clean
sudo apt update

# Retry installation
./install-developer-tools.sh --all
```

#### Docker Permission Denied

**Problem**: `Got permission denied while trying to connect to the Docker daemon socket`

```bash
# Solution 1: Add user to docker group (if not already done)
sudo usermod -aG docker $USER

# Log out and log back in, or use:
newgrp docker

# Solution 2: Start Docker service (WSL2)
sudo service docker start

# Verify
docker ps
```

#### NVM Not Found After Installation

**Problem**: `nvm: command not found` after Node.js installation

```bash
# Solution: Reload shell configuration
source ~/.bashrc

# Or manually load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Verify
nvm --version
```

#### Java/Maven/Gradle Not Found

**Problem**: Commands not found despite successful installation

```bash
# Solution: Check JAVA_HOME
echo $JAVA_HOME

# If empty, reload configuration
source ~/.bashrc

# Manually set if needed (add to ~/.bashrc)
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

#### Disk Space Issues

**Problem**: Installation fails due to insufficient disk space

```bash
# Check available space
df -h

# Clean up APT cache
sudo apt clean
sudo apt autoremove -y

# Clean up Docker (if installed)
docker system prune -a

# Check space again
df -h
```

#### Jenkins Won't Start

**Problem**: Jenkins service fails to start

```bash
# Check service status
sudo systemctl status jenkins

# View logs
sudo journalctl -u jenkins -n 50

# Common solution: Java not installed
# Reinstall with Java:
./install-developer-tools.sh --java21 --jenkins

# Restart service
sudo systemctl restart jenkins
```

#### SSL Certificate Errors

**Problem**: Certificate verification failures during downloads

```bash
# Solution 1: Use --insecure flag
./install-developer-tools.sh --all --insecure

# Solution 2: Update CA certificates
sudo apt install ca-certificates
sudo update-ca-certificates

# Solution 3: For corporate proxies, import company CA
sudo cp company-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

#### WSL2 Network Issues

**Problem**: Network connectivity issues in WSL2

```bash
# Solution: Reset network stack (in PowerShell as Admin)
# wsl --shutdown
# netsh winsock reset
# netsh int ip reset

# Then restart WSL
# wsl
```

### Getting Detailed Logs

Enable verbose output for debugging:

```bash
# Run with Bash debugging enabled
bash -x ./install-developer-tools.sh --all 2>&1 | tee install.log

# This creates an install.log file with detailed output
```

### Rollback/Uninstallation

To remove installed components:

#### Remove Oh My Bash

```bash
rm -rf ~/.oh-my-bash
# Restore original .bashrc from backup
mv ~/.bashrc.pre-oh-my-bash ~/.bashrc
```

#### Remove Node.js/NVM

```bash
rm -rf ~/.nvm
# Remove NVM lines from .bashrc
```

#### Remove Docker

```bash
sudo apt purge docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

#### Remove Jenkins

```bash
sudo systemctl stop jenkins
sudo systemctl disable jenkins
sudo apt purge jenkins
sudo rm -rf /var/lib/jenkins
```

---

## Architecture

### Script Structure

```
wsl-ubuntu/developer-tools/
├── install-developer-tools.sh    # Main orchestrator script
├── README.md                      # This file
├── oh-my-bash/
│   ├── install-oh-my-bash.sh
│   └── README.md
├── java/
│   ├── install-jdk-21.sh
│   └── README.md
├── python/
│   ├── install-virtualenv.sh
│   └── README.md
├── nodejs/
│   ├── install-nodejs.sh
│   └── README.md
├── docker/
│   ├── install-docker.sh
│   └── README.md
├── kubectl/
│   ├── install-kubectl.sh
│   └── README.md
├── helm/
│   ├── install-helm-cli.sh
│   └── README.md
└── jenkins/
    ├── install-jenkins.sh
    ├── configure-jenkins-tools.sh
    └── README.md
```

### Remote Installer URLs

The main script fetches component installers from GitHub:

| Component | Installer URL |
|-----------|---------------|
| Oh My Bash | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/oh-my-bash/install-oh-my-bash.sh` |
| Java 21 | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/java/install-jdk-21.sh` |
| Python | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/python/install-virtualenv.sh` |
| Node.js | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh` |
| Docker | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/docker/install-docker.sh` |
| kubectl | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/kubectl/install-kubectl.sh` |
| Helm | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/helm/install-helm-cli.sh` |
| Jenkins | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/install-jenkins.sh` |
| Jenkins Config | `https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/configure-jenkins-tools.sh` |

### Design Patterns

- **Modular Architecture**: Each component has its own installer for maintainability
- **Idempotency**: Safe to run multiple times; doesn't break existing installations
- **Fail-Fast**: Unknown options cause immediate exit
- **Progressive Enhancement**: Core tools first, optional components second
- **Transparent Execution**: Progress banners show what's happening
- **Minimal Side Effects**: Only modifies necessary files and creates `.hushlogin`

---

## Development

### Contributing

Contributions are welcome! Here's how to contribute:

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/toolbox.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/add-rust-support
   ```

3. **Make your changes**
   - Add new installer script
   - Update main `install-developer-tools.sh`
   - Add documentation
   - Test on fresh Ubuntu/WSL2 environment

4. **Test thoroughly**
   ```bash
   # Test individual component
   ./install-developer-tools.sh --your-new-flag
   
   # Test with other components
   ./install-developer-tools.sh --your-new-flag --docker --osh
   
   # Test idempotency (run twice)
   ./install-developer-tools.sh --your-new-flag
   ./install-developer-tools.sh --your-new-flag
   ```

5. **Submit a pull request**
   - Describe the changes
   - Include testing evidence
   - Update README.md with new component documentation

### Adding a New Component

To add a new tool (e.g., Rust):

1. **Create subdirectory**
   ```bash
   mkdir -p wsl-ubuntu/developer-tools/rust
   ```

2. **Create installer script**
   ```bash
   # wsl-ubuntu/developer-tools/rust/install-rust.sh
   #!/bin/bash
   echo "Installing Rust..."
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
   source $HOME/.cargo/env
   echo "Rust installation complete!"
   ```

3. **Update main script**
   - Add `INSTALL_RUST=false` variable
   - Add `--rust` flag parsing
   - Add conditional installer call

4. **Document**
   - Create `rust/README.md`
   - Update this README with component details

### Testing Guidelines

- Test on fresh Ubuntu 22.04 LTS
- Test on WSL2 (Ubuntu)
- Verify idempotency (run script twice)
- Test flag combinations
- Verify environment variables
- Check service status (for daemon components)

---

## FAQ

### General Questions

**Q: Is this script safe to run multiple times?**  
A: Yes, the script is idempotent. Package managers skip already-installed packages, and component installers handle existing installations gracefully.

**Q: Can I install individual components after running the script?**  
A: Yes, simply run the script again with the additional flags you need.

**Q: How much disk space do I need?**  
A: Minimum 5 GB, but 10 GB+ is recommended if installing all components.

**Q: Can I use this on Debian?**  
A: Yes, it works on Debian 11+ since it uses APT package manager.

### WSL2 Questions

**Q: Why doesn't Docker start automatically in WSL2?**  
A: WSL2 doesn't use systemd by default. You need to manually start the Docker service with `sudo service docker start` or enable systemd in WSL 2.0+.

**Q: Can I access Jenkins running in WSL2 from Windows?**  
A: Yes, access it at `http://localhost:8080` from your Windows browser.

**Q: How do I improve performance in WSL2?**  
A: Work within the WSL file system (`/home/`) instead of Windows mounts (`/mnt/c/`), and configure memory limits in `.wslconfig`.

### Tool-Specific Questions

**Q: Which version of Node.js is installed?**  
A: The latest LTS (Long-Term Support) version at the time of installation.

**Q: Can I install a different Java version?**  
A: Currently, the script installs Java 21 LTS. You can modify the installer or install other versions manually.

**Q: How do I switch Node.js versions?**  
A: Use NVM: `nvm install 18`, `nvm use 18`, `nvm list`

**Q: Where is Jenkins data stored?**  
A: All Jenkins data is in `/var/lib/jenkins`, including jobs, plugins, and configuration.

### Troubleshooting Questions

**Q: What if I get "command not found" after installation?**  
A: Reload your shell with `source ~/.bashrc` or restart your terminal.

**Q: How do I fix Docker permission errors?**  
A: Ensure you're in the docker group and log out/in: `sudo usermod -aG docker $USER`, then logout/login or `newgrp docker`.

**Q: The script fails halfway through. Can I continue?**  
A: Yes, just run the script again. It will skip already-installed components.

---

## License

MIT License - see [LICENSE](../../LICENSE) file for details.

---

## Additional Resources

- [WSL2 Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Docker Documentation](https://docs.docker.com/)
- [Jenkins User Documentation](https://www.jenkins.io/doc/)
- [NVM GitHub Repository](https://github.com/nvm-sh/nvm)
- [Oh My Bash GitHub Repository](https://github.com/ohmybash/oh-my-bash)

---

**Questions or issues?** Open an issue on [GitHub](https://github.com/adautomendes/toolbox/issues).