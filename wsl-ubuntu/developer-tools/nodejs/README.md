# Node.js via NVM (WSL)

## Overview
Installs NVM (latest release) and sets up the latest LTS version of Node.js, relying on GitHub API for the current tag.

## Script
- [wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh](install-nodejs.sh)

## What it does
- Parses `--insecure` to optionally relax TLS checks for curl.
- Queries GitHub Releases for the latest NVM tag using `curl` + `jq`.
- If `~/.nvm` is missing:
  - Runs the NVM install script for that tag.
  - Loads NVM in the current shell and installs Node.js LTS (`nvm install --lts`).

## Requirements
- Bash, `curl`, `jq`.
- Internet access to GitHub.
- Write access to `~/.nvm` and `~/.bashrc` (NVM installer updates shell config).

## Usage
```bash
cd wsl-ubuntu/developer-tools/nodejs
./install-nodejs.sh [--insecure]
```
- `--insecure`: Passes `--insecure` to curl (only use in trusted networks).

After installation, **open a new shell** or source your profile so `nvm` is available.

## Verification
```bash
nvm --version
node -v
npm -v
```

## Notes
- The installer skips NVM setup if `~/.nvm` already exists; remove it first if you want a fresh install.
- To install a specific Node.js version later, use `nvm install <version>` and `nvm use <version>`.
