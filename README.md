# 🧰 Toolbox

> A comprehensive collection of automation scripts and developer tools for streamlining Windows, WSL, and Linux development environments.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Platform: WSL](https://img.shields.io/badge/Platform-WSL2-orange.svg)](https://docs.microsoft.com/windows/wsl/)
[![Platform: Ubuntu](https://img.shields.io/badge/Platform-Ubuntu-red.svg)](https://ubuntu.com/)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Windows Tools](#windows-tools)
  - [Windows Cleanup](#windows-cleanup)
- [WSL Ubuntu Tools](#wsl-ubuntu-tools)
  - [WSL Distribution Creator](#wsl-distribution-creator)
  - [Developer Tools Suite](#developer-tools-suite)
  - [Font Installation](#font-installation)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## 🎯 Overview

**Toolbox** is a curated collection of battle-tested automation scripts designed to eliminate the tedium of setting up and maintaining development environments. Whether you're spinning up a fresh WSL2 instance, installing a complete development stack, or cleaning up your Windows system, these scripts provide a consistent, repeatable, and time-saving solution.

### Why Toolbox?

- **🚀 Zero to Hero**: Transform a bare system into a fully-equipped development environment in minutes
- **🔄 Idempotent**: Safe to run multiple times without breaking existing setups
- **📦 Modular**: Install only what you need with granular control
- **🎨 Developer-First**: Opinionated defaults based on best practices and real-world usage
- **📝 Well-Documented**: Every tool comes with comprehensive documentation and usage examples

## ✨ Features

- **Automated Environment Setup**: Complete WSL Ubuntu distribution creation and configuration
- **One-Command Installs**: Install entire development stacks with single commands
- **System Maintenance**: Windows cleanup utilities for disk optimization
- **Developer Tools**: Pre-configured installations of Docker, Java, Node.js, Python, Jenkins, and more
- **Shell Enhancements**: Oh My Bash with powerline theme for an improved terminal experience
- **Font Management**: Easy installation of modern coding fonts (Monaspace family)
- **Safe Operations**: Built-in checks and confirmations to prevent accidental system damage

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/adautomendes/toolbox.git
cd toolbox

# Make scripts executable (Linux/WSL)
find . -type f -name "*.sh" -exec chmod +x {} \;

# Example: Install complete developer environment on WSL Ubuntu
cd wsl-ubuntu/developer-tools
./install-developer-tools.sh --osh --java --python --nodejs --docker

# Example: Create a new WSL Ubuntu distro (Windows PowerShell as Admin)
cd wsl-ubuntu/create-new-distro
.\create-new-distro.ps1
```

## 📂 Repository Structure

```
toolbox/
├── windows/                          # Windows-specific tools
│   └── cleanup/                      # System cleanup utilities
│       ├── windows-cleanup.bat       # Temp files and disk cleanup script
│       └── README.md
│
└── wsl-ubuntu/                       # WSL/Ubuntu tools
    ├── create-new-distro/            # WSL distribution creator
    │   ├── create-new-distro.ps1     # Automated WSL Ubuntu setup
    │   └── README.md
    │
    ├── developer-tools/              # Development environment tools
    │   ├── install-developer-tools.sh # Master installer script
    │   ├── README.md
    │   │
    │   ├── docker/                   # Docker Engine installer
    │   │   ├── install-docker.sh
    │   │   └── README.md
    │   │
    │   ├── java/                     # JDK 21 + Maven + Gradle
    │   │   ├── install-jdk-21.sh
    │   │   └── README.md
    │   │
    │   ├── jenkins/                  # Jenkins CI/CD server
    │   │   ├── install-jenkins.sh
    │   │   └── README.md
    │   │
    │   ├── nodejs/                   # Node.js via NVM
    │   │   ├── install-nodejs.sh
    │   │   └── README.md
    │   │
    │   ├── oh-my-bash/              # Shell enhancement
    │   │   ├── install-oh-my-bash.sh
    │   │   └── README.md
    │   │
    │   └── python/                   # Python virtualenv setup
    │       ├── install-virtualenv.sh
    │       └── README.md
    │
    └── fonts/                        # Font installation tools
        ├── install-monaspace.sh      # Monaspace font family
        └── README.md
```

## 🪟 Windows Tools

### Windows Cleanup

**Location**: [windows/cleanup](windows/cleanup)

Automated batch script for cleaning temporary files and optimizing Windows system performance.

#### Features:
- Removes temporary files from Windows temp folders
- Clears browser cache and temporary data
- Empties recycle bin
- Removes old log files
- Optimizes disk space

#### Usage:
```cmd
# Run with Administrator privileges
cd windows\cleanup
windows-cleanup.bat
```

⚠️ **Warning**: This script deletes files. Review before running to understand what will be removed.

**[📖 Full Documentation](windows/cleanup/README.md)**

---

## 🐧 WSL Ubuntu Tools

### WSL Distribution Creator

**Location**: [wsl-ubuntu/create-new-distro](wsl-ubuntu/create-new-distro)

PowerShell automation script to create and configure custom WSL Ubuntu distributions with pre-installed developer tools.

#### Features:
- 🔄 **Automated Installation**: Creates WSL Ubuntu distro with custom name and location
- 👤 **User Configuration**: Sets up custom Linux user with specified credentials
- 🔐 **Security Setup**: Automatically grants sudo privileges
- 🛠️ **Developer Tools**: Installs development tools via automated bootstrap script
- 🧹 **Clean Installation**: Removes existing distro before installation for fresh setup
- ⚙️ **Default User**: Configures distro to login with your user by default (not root)

#### Prerequisites:
- Windows 10/11 with WSL2 enabled
- PowerShell 5.1+
- Internet connection
- WSL feature enabled (run `wsl --install` if needed)

#### Quick Start:
```powershell
# Run PowerShell as Administrator
cd wsl-ubuntu\create-new-distro

# Edit create-new-distro.ps1 to configure:
# - $distroName = "My_Awesome_Ubuntu"
# - $linuxUser = "youruser"
# - $linuxPass = "yourpassword"
# - $locationPath = "C:\WSL\$distroName"

.\create-new-distro.ps1
```

**[📖 Full Documentation](wsl-ubuntu/create-new-distro/README.md)**

---

### Developer Tools Suite

**Location**: [wsl-ubuntu/developer-tools](wsl-ubuntu/developer-tools)

Comprehensive master installer that automates a consistent, batteries-included Linux development environment with a single command.

#### Master Installer Features:
- ✅ **Modular Installation**: Install only the tools you need with CLI flags
- 🎯 **Opinionated Defaults**: Curated base toolset for day-one productivity
- 🔄 **Idempotent**: Safe to run multiple times
- 🖥️ **Cross-Platform**: Works on Ubuntu/Debian and WSL2
- 📦 **Core Tools Included**: git, curl, wget, vim, build-essential, and more

#### Supported Platforms:
- Ubuntu/Debian systems using `apt`
- WSL2 on Windows 11+ (recommended for Docker)

#### Requirements:
- `sudo` privileges
- Internet connectivity
- ~5 GB free disk space (varies by selected tools)

#### Master Installation Command:

```bash
cd wsl-ubuntu/developer-tools
./install-developer-tools.sh [OPTIONS]

# Options:
#   --osh       Install Oh My Bash with powerline theme
#   --java      Install OpenJDK 21, Maven, and Gradle
#   --python    Install pipx and virtualenv
#   --nodejs    Install Node.js LTS via NVM
#   --docker    Install Docker Engine with Docker Compose
#   --jenkins   Install Jenkins LTS
```

#### Usage Examples:

```bash
# Install everything
./install-developer-tools.sh --osh --java --python --nodejs --docker --jenkins

# Install only essential development tools
./install-developer-tools.sh --java --nodejs --docker

# Install Python and Docker only
./install-developer-tools.sh --python --docker
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/README.md)**

---

#### 🐳 Docker

**Location**: [wsl-ubuntu/developer-tools/docker](wsl-ubuntu/developer-tools/docker)

Automates Docker Engine installation on Ubuntu/WSL using Docker's official APT repository.

**What It Installs**:
- Docker CE (Community Edition)
- Docker CLI
- containerd.io
- Docker Buildx plugin
- Docker Compose plugin

**Key Features**:
- Removes conflicting packages automatically
- Adds user to `docker` group for sudo-less operation
- WSL2 optimized with systemd support

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/docker
./install-docker.sh

# Verify installation
docker version
docker run --rm hello-world
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/docker/README.md)**

---

#### ☕ Java Development Kit

**Location**: [wsl-ubuntu/developer-tools/java](wsl-ubuntu/developer-tools/java)

Installs a complete Java development environment with OpenJDK, Maven, and Gradle.

**What It Installs**:
- OpenJDK 21 (21.0.2)
- Apache Maven 3.9.12
- Gradle 8.7

**Key Features**:
- No `sudo` required - installs to `~/Java/`
- Automatic environment variable configuration in `~/.bashrc`
- Sets up `JAVA_HOME`, `MAVEN_HOME`, and `GRADLE_HOME`
- Skips tools that are already installed

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/java
./install-jdk-21.sh
source ~/.bashrc

# Verify installation
java -version
mvn -version
gradle -version
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/java/README.md)**

---

#### 🔧 Jenkins CI/CD

**Location**: [wsl-ubuntu/developer-tools/jenkins](wsl-ubuntu/developer-tools/jenkins)

Sets up a local Jenkins instance by downloading the latest Jenkins WAR file.

**What It Does**:
- Downloads latest `jenkins.war` to `~/Jenkins/`
- Creates `JENKINS_HOME` at `~/Jenkins/home`
- Adds `jenkins-run` alias to start Jenkins easily
- Configurable HTTP port (default: 9000)

**Prerequisites**:
- Java Runtime Environment must be installed

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/jenkins
./install-jenkins.sh 9000  # Optional port argument (default: 9000)

# Restart terminal, then start Jenkins
jenkins-run

# Access at http://localhost:9000
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/jenkins/README.md)**

---

#### 🟢 Node.js

**Location**: [wsl-ubuntu/developer-tools/nodejs](wsl-ubuntu/developer-tools/nodejs)

Installs Node.js LTS version via NVM (Node Version Manager) for easy version management.

**What It Installs**:
- NVM (latest release from GitHub)
- Node.js LTS version
- npm (included with Node.js)

**Key Features**:
- Easy Node.js version switching
- Automatic `~/.bashrc` configuration
- Fetches latest NVM release dynamically from GitHub API

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/nodejs
./install-nodejs.sh

# Open new terminal, then verify
nvm --version
node -v
npm -v

# Manage Node.js versions
nvm install 18        # Install Node.js 18
nvm use 18            # Switch to Node.js 18
nvm list              # List installed versions
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/nodejs/README.md)**

---

#### 🎨 Oh My Bash

**Location**: [wsl-ubuntu/developer-tools/oh-my-bash](wsl-ubuntu/developer-tools/oh-my-bash)

Enhances your Bash shell with Oh My Bash framework and the beautiful powerline theme.

**What It Does**:
- Installs Oh My Bash framework
- Configures powerline theme
- Backs up existing `~/.bashrc` with timestamp
- Provides syntax highlighting and auto-completion

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/oh-my-bash
./install-oh-my-bash.sh

# Restart terminal to see changes
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/oh-my-bash/README.md)**

---

#### 🐍 Python Virtual Environments

**Location**: [wsl-ubuntu/developer-tools/python](wsl-ubuntu/developer-tools/python)

Installs `pipx` and `virtualenv` for isolated Python environment management.

**What It Installs**:
- pipx (for installing Python applications in isolated environments)
- virtualenv (for creating Python virtual environments)

**Key Features**:
- System-wide Python isolation
- Clean package management
- Automatic PATH configuration

**Standalone Usage**:
```bash
cd wsl-ubuntu/developer-tools/python
./install-virtualenv.sh

# Create and activate virtual environment
virtualenv myproject-env
source myproject-env/bin/activate

# Deactivate when done
deactivate
```

**[📖 Full Documentation](wsl-ubuntu/developer-tools/python/README.md)**

---

### Font Installation

#### 🔤 Monaspace Fonts

**Location**: [wsl-ubuntu/fonts](wsl-ubuntu/fonts)

Installs the modern Monaspace font family designed for code editors and terminals.

**Fonts Included**:
- Monaspace Neon
- Monaspace Argon
- Monaspace Krypton
- Monaspace Radon
- Monaspace Xenon

**Usage**:
```bash
cd wsl-ubuntu/fonts
./install-monaspace.sh

# Verify installation
fc-list | grep -i monaspace
```

⚠️ **Note**: Restart your terminal or IDE to use the new fonts.

**[📖 Full Documentation](wsl-ubuntu/fonts/README.md)**

---

## 💻 Requirements

### Windows Tools
- Windows 10/11
- Administrator privileges
- PowerShell 5.1+ (for WSL tools)

### WSL/Ubuntu Tools
- Ubuntu 20.04+ or Debian-based distribution
- WSL2 (for Windows users)
- `sudo` privileges
- Internet connection
- 5-10 GB free disk space (depending on tools installed)

### Common Dependencies
- `curl` - Usually pre-installed
- `wget` - Usually pre-installed
- `git` - Installed by developer-tools script

## 📥 Installation

### Clone the Repository

```bash
# Via HTTPS
git clone https://github.com/adautomendes/toolbox.git

# Via SSH
git clone git@github.com:adautomendes/toolbox.git

# Navigate to directory
cd toolbox
```

### Make Scripts Executable (Linux/WSL)

```bash
# Make all shell scripts executable
find . -type f -name "*.sh" -exec chmod +x {} \;

# Or make individual scripts executable
chmod +x wsl-ubuntu/developer-tools/install-developer-tools.sh
```

## 📚 Usage Examples

### Scenario 1: Fresh WSL Development Environment

```powershell
# 1. Create new WSL distro (PowerShell as Admin on Windows)
cd toolbox\wsl-ubuntu\create-new-distro
.\create-new-distro.ps1
```

```bash
# 2. Inside your new WSL distro, install development tools
cd /mnt/c/path/to/toolbox/wsl-ubuntu/developer-tools
./install-developer-tools.sh --osh --java --nodejs --docker --python
```

### Scenario 2: Docker-Only Installation

```bash
cd wsl-ubuntu/developer-tools/docker
./install-docker.sh

# Verify
docker --version
docker compose version
```

### Scenario 3: Java Development Setup

```bash
cd wsl-ubuntu/developer-tools/java
./install-jdk-21.sh
source ~/.bashrc

# Start coding
java -version
mvn -version
```

### Scenario 4: Node.js Project Setup

```bash
cd wsl-ubuntu/developer-tools/nodejs
./install-nodejs.sh

# New terminal
nvm install --lts
npm install -g yarn typescript
```

### Scenario 5: Clean Windows System

```cmd
# Run as Administrator
cd toolbox\windows\cleanup
windows-cleanup.bat
```

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how you can help:

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-tool
   ```
3. **Make your changes**
   - Add your script to the appropriate directory
   - Include a comprehensive README.md
   - Follow existing code style and conventions
4. **Test thoroughly**
   - Test on fresh installations
   - Verify idempotency (safe to run multiple times)
   - Check for edge cases
5. **Commit your changes**
   ```bash
   git commit -m "Add amazing-tool for XYZ"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/amazing-tool
   ```
7. **Open a Pull Request**

### Contribution Guidelines

- **Documentation**: Every script must have a README.md explaining its purpose, usage, and requirements
- **Error Handling**: Include proper error checking and user-friendly messages
- **Idempotency**: Scripts should be safe to run multiple times
- **Cross-Platform**: Specify supported platforms clearly
- **Dependencies**: List all prerequisites and check for them in scripts
- **Security**: Never hardcode credentials; prompt users or use environment variables

### Ideas for Contributions

- Additional language runtimes (Go, Rust, Ruby, etc.)
- Database installation scripts (PostgreSQL, MySQL, MongoDB)
- IDE configuration automation
- Dotfile management
- System monitoring tools
- Backup and restore utilities
- Network configuration tools

## 🔧 Troubleshooting

### Common Issues

#### WSL Installation Fails
```bash
# Ensure WSL2 is enabled
wsl --set-default-version 2

# Update WSL
wsl --update
```

#### Docker Permission Denied
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or run
newgrp docker
```

#### Script Permission Denied
```bash
# Make script executable
chmod +x script-name.sh
```

#### Java/Node Not Found After Installation
```bash
# Reload shell configuration
source ~/.bashrc

# Or open a new terminal session
```

#### NVM Command Not Found
```bash
# Ensure NVM is in your shell config
cat ~/.bashrc | grep -i nvm

# Manually source it
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### Getting Help

1. Check the specific tool's README for detailed troubleshooting
2. Review error messages carefully - they often indicate the solution
3. Verify all prerequisites are met
4. Check that you have necessary permissions (sudo, admin)
5. Open an issue on GitHub with:
   - Your OS and version
   - Script being run
   - Complete error message
   - Steps to reproduce

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### MIT License Summary

- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ❌ Liability
- ❌ Warranty

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/adautomendes/toolbox/issues)
- **Discussions**: [GitHub Discussions](https://github.com/adautomendes/toolbox/discussions)

---

<div align="center">

**Made with ❤️ for developers, by a Developer/QA/Devops/Architect**

If this project helped you, consider giving it a ⭐ on GitHub!

</div>
