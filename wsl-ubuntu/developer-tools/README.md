# Developer Tools Installation Script

Automate a consistent, batteries-included Linux dev environment with a single command. This script installs a curated base toolchain and, optionally, language/runtime stacks and DevOps tooling. It is safe to run multiple times and designed to work well in WSL2 and standard Ubuntu/Debian environments.

## 📋 Table of Contents
- [Developer Tools Installation Script](#developer-tools-installation-script)
  - [📋 Table of Contents](#-table-of-contents)
  - [🎯 Overview](#-overview)
    - [Highlights](#highlights)
  - [🖥️ Supported Platforms](#️-supported-platforms)
  - [🚀 Quick Start](#-quick-start)
  - [🔧 Command Reference](#-command-reference)
    - [Tool Selection](#tool-selection)
    - [Configuration](#configuration)
  - [🧭 What the Script Does](#-what-the-script-does)
  - [📦 Installed Components](#-installed-components)
    - [Always Installed](#always-installed)
    - [Optional (by flag)](#optional-by-flag)
      - [`--osh` (Oh My Bash)](#--osh-oh-my-bash)
      - [`--java21` (Java Development)](#--java21-java-development)
      - [`--python` (Python Tooling)](#--python-python-tooling)
      - [`--nodejs` (Node.js via NVM)](#--nodejs-nodejs-via-nvm)
      - [`--docker` (Docker Engine)](#--docker-docker-engine)
      - [`--jenkins` (Jenkins LTS)](#--jenkins-jenkins-lts)
  - [💡 Usage Examples](#-usage-examples)
  - [✅ Post-Install Checklist](#-post-install-checklist)
  - [🔐 Security \& Networking](#-security--networking)
  - [🔍 Troubleshooting](#-troubleshooting)
  - [🧩 Internals \& Script Map](#-internals--script-map)
  - [🤝 Contributing](#-contributing)
  - [📄 License](#-license)

## 🎯 Overview

This script orchestrates system prep, core CLI tooling, and optional developer stacks using small, focused installers. It updates your apt cache, upgrades existing packages, installs a standard base set, and then conditionally installs additional tools based on flags. A minimal shell noise experience is enabled by touching `~/.hushlogin`.

### Highlights
- Modular flags to install only what you need
- Opinionated base toolset for day‑one productivity
- Clean output with progress banners
- Safe reruns; uses package manager idempotency

## 🖥️ Supported Platforms
- Ubuntu/Debian systems using `apt`
- WSL2 (Windows Subsystem for Linux) on Windows 11+ (recommended for Docker)

Requirements:
- `sudo` privileges
- Internet connectivity
- ~5 GB free disk (varies by flags)

## 🚀 Quick Start

From a cloned repo:

```bash
cd /home/adauto/repo/toolbox/wsl-ubuntu/developer-tools
chmod +x install-developer-tools.sh
./install-developer-tools.sh --all
```

Remote (no clone):

```bash
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash -s -- --all
```

## 🔧 Command Reference

Flags can be combined freely. Unknown flags cause the script to exit with an error.

### Tool Selection

| Flag | Purpose | Summary |
|---|---|---|
| `--osh` | Shell UX | Oh My Bash with themes, aliases, completion |
| `--java21` | Java stack | JDK 21 + Maven + Gradle |
| `--python` | Python tooling | Python tools via `virtualenv` installer |
| `--nodejs` | Node.js LTS | NVM + latest LTS Node.js + npm/npx |
| `--docker` | Containers | Docker Engine + CLI (+ Compose if available) |
| `--jenkins` | CI server | Jenkins LTS as a service |
| `--all` | Everything | Enables all of the above |

### Configuration

| Flag | Effect | When to use |
|---|---|---|
| `--insecure` | Adds `--insecure` to `curl` calls and passes through to some sub-installers | Corporate proxies, self‑signed cert environments |

Notes:
- `--insecure` is forwarded to the Oh My Bash and Node.js installers. Java, Python, Docker, and Jenkins installers are fetched with `curl` (respecting `--insecure`) but are not passed an additional installer argument unless their scripts read it from `curl` flags.

## 🧭 What the Script Does

High‑level flow of `install-developer-tools.sh`:

1. Parse flags and echo the effective configuration
2. `sudo apt update && sudo apt upgrade -y`
3. Install base packages via `apt install -y`
4. `sudo apt autoremove -y` to clean unused deps
5. Conditional installs via remote installers (see map below)
   - If both Java 21 and Jenkins are selected, Maven and Gradle tools are configured inside Jenkins automatically
6. Create `~/.hushlogin` to suppress MOTD/login noise
7. Prompt to restart terminal

Base packages installed every run:

```
snapd curl tree yq jq git wget build-essential python3 python3-pip unzip
```

## 📦 Installed Components

### Always Installed
- `curl`, `wget`, `git`, `tree`, `jq`, `yq`, `snapd`, `build-essential`, `python3`, `python3-pip`, `unzip`

### Optional (by flag)

#### `--osh` (Oh My Bash)
- Enhanced Bash UX: themes, aliases, completion, git prompt
- `~/.bashrc` is updated by the installer
- More: [wsl-ubuntu/developer-tools/oh-my-bash/README.md](wsl-ubuntu/developer-tools/oh-my-bash/README.md)

#### `--java21` (Java Development)
- JDK 21 (LTS), plus Maven and Gradle
- Typical homes: `/usr/lib/jvm`, `~/.m2`, `~/.gradle`
- More: [wsl-ubuntu/developer-tools/java/README.md](wsl-ubuntu/developer-tools/java/README.md)

#### `--python` (Python Tooling)
- `virtualenv` for isolated environments
- Ensures modern `pip`; development headers handled by base image tooling
- More: [wsl-ubuntu/developer-tools/python/README.md](wsl-ubuntu/developer-tools/python/README.md)

#### `--nodejs` (Node.js via NVM)
- Installs NVM to `~/.nvm/`, then the latest LTS Node.js
- Includes `npm` and `npx`
- More: [wsl-ubuntu/developer-tools/nodejs/README.md](wsl-ubuntu/developer-tools/nodejs/README.md)

#### `--docker` (Docker Engine)
- Docker Engine + CLI (Compose if available)
- Adds current user to `docker` group for rootless use
- WSL2 users may need to start the service manually (see below)
- More: [wsl-ubuntu/developer-tools/docker/README.md](wsl-ubuntu/developer-tools/docker/README.md)

#### `--jenkins` (Jenkins LTS)
- Runs as a system service on port 8080
- Initial admin password: `/var/lib/jenkins/secrets/initialAdminPassword`
- More: [wsl-ubuntu/developer-tools/jenkins/README.md](wsl-ubuntu/developer-tools/jenkins/README.md)

## 💡 Usage Examples

```bash
# Web stack
./install-developer-tools.sh --nodejs --docker --osh

# Full‑stack Java
./install-developer-tools.sh --java21 --docker --jenkins --osh

# Python data science foundation
./install-developer-tools.sh --python --docker

# Everything behind a corporate proxy
./install-developer-tools.sh --all --insecure
```

## ✅ Post-Install Checklist

Restart your shell or source your profile:

```bash
source ~/.bashrc || true
```

Verify versions (run what applies to your flags):

```bash
git --version
python3 --version
node --version && npm --version
java -version && mvn -version && gradle -version
docker --version && docker ps
```

WSL2 + Docker tips:

```bash
sudo service docker start
docker run hello-world
# If "permission denied": re-login after group change
sudo usermod -aG docker "$USER"
```

Environment checks (if applicable):

```bash
echo "$NVM_DIR"
echo "$JAVA_HOME"
```

## 🔐 Security & Networking

- `--insecure` passes `--insecure` to `curl`, disabling TLS verification. Use only when required (e.g., corporate proxies/self‑signed certs).
- For proxy environments, ensure your `http_proxy`/`https_proxy` variables are exported before running the script.

## 🔍 Troubleshooting

- Permission denied when running the script
   - `chmod +x install-developer-tools.sh`
- Apt cannot locate packages
   - `sudo apt update` then retry
- Docker "permission denied"
   - `sudo usermod -aG docker $USER` and log out/in
- NVM not loaded in new shells
   - Ensure your `~/.bashrc` sources NVM:
      ```bash
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      ```
- Low disk space during install
   - `sudo apt clean && sudo apt autoremove` and check `df -h`

If issues persist:
- Check sub‑tool READMEs linked above
- Review the script output (progress banners include the active step)

## 🧩 Internals & Script Map

Entry point: [wsl-ubuntu/developer-tools/install-developer-tools.sh](wsl-ubuntu/developer-tools/install-developer-tools.sh)

Remote installers fetched via `curl` and piped to `bash`:

- Oh My Bash: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/oh-my-bash/install-oh-my-bash.sh
   - Invoked with: `bash -s -- $INSECURE`
- Java: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/java/install-jdk-21.sh
- Python: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/python/install-virtualenv.sh
- Node.js: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh
   - Invoked with: `bash -s -- $INSECURE`
- Docker: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/docker/install-docker.sh
- Jenkins: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/install-jenkins.sh

Additional conditional step:

- Jenkins tools config: https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/configure-jenkins-tools.sh
   - Invoked automatically when `--java21` and `--jenkins` are both set to configure Maven/Gradle tools in Jenkins

Behavioral notes:
- Unknown options cause an immediate exit (`exit 1`)
- Progress banners echo effective options and active phases
- `.hushlogin` is created to reduce login noise

## 🤝 Contributing

Improvements and new tools are welcome:
- Propose changes via PR after testing on a fresh Ubuntu/WSL environment
- For a new tool: add a subdirectory under `developer-tools/`, provide an installer, update this README, and keep installers idempotent

## 📄 License

MIT License. See [LICENSE](../../LICENSE).