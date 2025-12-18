# Oh My Bash Installer (WSL)

## Overview
Installs Oh My Bash with the "powerline" theme and preserves any existing `.bashrc` via timestamped backup.

## Script
- [wsl-ubuntu/developer-tools/oh-my-bash/install-oh-my-bash.sh](install-oh-my-bash.sh)

## What it does
- Parses `--insecure` to allow curl without TLS verification when needed.
- If `~/.oh-my-bash` is absent:
  - Backs up the current `~/.bashrc` to `~/.bashrc.backup_<timestamp>`.
  - Runs the official Oh My Bash installer via curl.
  - Forces the theme to `powerline` inside `~/.bashrc`.

## Requirements
- Bash, `curl`.
- Write access to `~/.bashrc`.

## Usage
```bash
cd wsl-ubuntu/developer-tools/oh-my-bash
./install-oh-my-bash.sh [--insecure]
```
- `--insecure`: Passes `--insecure` to curl (only use in trusted networks).

After installation, start a new shell session to load Oh My Bash with the powerline theme.

## Notes
- Existing installs are left untouched; rerun after removing `~/.oh-my-bash` if you want a clean reinstall.
- Keep the generated `~/.bashrc.backup_*` file if you need to restore previous settings.
