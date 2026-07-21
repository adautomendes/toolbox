# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal collection of standalone automation scripts (Bash, PowerShell, Batch) for provisioning and
maintaining Windows, WSL2, and Ubuntu/Debian developer environments. There is no build system, package
manifest, or test suite — every script is meant to be read and run directly.

## Commands

There is no build/lint/test tooling. The relevant commands are:

```bash
# Make a script executable before running it locally
chmod +x path/to/script.sh

# Run the master developer-tools installer (from its own directory)
cd wsl-ubuntu/developer-tools
./install-developer-tools.sh --osh --java21 --python --nodejs --docker --kubectl --helm --jenkins
./install-developer-tools.sh --all            # everything
./install-developer-tools.sh --all --insecure # skip TLS verification (corporate proxy/self-signed certs)

# Run any component installer standalone (each is self-contained)
cd wsl-ubuntu/developer-tools/<component>
./install-<component>.sh [--insecure]

# Create a fresh WSL Ubuntu distro (Windows PowerShell, run as Administrator)
cd wsl-ubuntu/create-new-distro
.\create-new-distro.ps1

# Windows temp/cache cleanup (Windows, run as Administrator)
cd windows\cleanup
windows-cleanup.bat
```

`push.sh` at the repo root is the author's personal commit/push shortcut
(`git add . && git commit -m "$(cat LATEST_COMMIT_MSG)" && git push origin main`) — it commits the
message currently stored in `LATEST_COMMIT_MSG`. Don't invoke it on the user's behalf; only edit
`LATEST_COMMIT_MSG` if explicitly asked to prep a commit message.

## Architecture

### Directory layout mirrors the tool hierarchy

```
windows/<tool>/                              # Windows-only scripts (.bat)
wsl-ubuntu/create-new-distro/                # PowerShell: provisions a new WSL distro end-to-end
wsl-ubuntu/developer-tools/install-developer-tools.sh   # orchestrator
wsl-ubuntu/developer-tools/<component>/install-*.sh      # one installer per tool, always with its own README.md
wsl-ubuntu/fonts/                            # font installers
```

Every leaf script directory has its own `README.md` documenting purpose, usage, and requirements — when
adding a new installer, add a matching README next to it and it needs to be added to the root `README.md` component table/TOC as well.

### The orchestrator pattern (`install-developer-tools.sh`)

`wsl-ubuntu/developer-tools/install-developer-tools.sh` is the master entry point. It:

1. Parses `--<component>` flags (plus `--all` and `--insecure`) into `INSTALL_*` booleans.
2. Installs a fixed set of core apt packages unconditionally (git, curl, wget, build-essential, python3, jq, yq, etc).
3. For each enabled component, fetches and pipes that component's installer straight from the GitHub raw
   URL for this repo (`https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/...`) via
   `curl -o- ... | bash -s -- $INSECURE`, rather than calling the local file relatively.
4. If both `--java21` and `--jenkins` are set, additionally runs `jenkins/configure-jenkins-tools.sh` to
   register Maven/Gradle as named Jenkins tools.

Because component installers are fetched from `main` on GitHub rather than run from the local checkout,
any change to a component script only takes effect for remote/orchestrated installs once it's pushed and
merged to `main`. `wsl-ubuntu/create-new-distro/create-new-distro.ps1` follows the same remote-fetch
pattern to bootstrap a brand-new distro.

### Conventions shared by every component installer

- `#!/bin/bash` scripts, no `set -e` — each step guards itself instead (see idempotency below).
- **Idempotent**: check before acting, e.g. `if ! command -v java &> /dev/null`, `if [ ! -d "$HOME/.nvm" ]`.
  Re-running any script must be safe.
- **No sudo for dev tools**: JDK/Maven/Gradle, kubectl, Helm, Jenkins, NVM/Node all install into
  `$HOME` (`~/Java/`, `~/kubernetes/`, `~/helm/`, `~/Jenkins/`, `~/.nvm/`) and append `export PATH=...`/
  env vars to `~/.bashrc`. `apt`-based installs (Docker, core packages) are the exception and do use `sudo`.
- **Dynamic "latest version" resolution** instead of hardcoding, typically via GitHub's API:
  `curl -s https://api.github.com/repos/<org>/<repo>/releases/latest | jq -r .tag_name`, or by scraping an
  index page (Maven's installer greps the Apache dist listing). Gradle and the JDK patch version are the
  exceptions and are pinned as explicit version variables at the top of the script — bump them there when
  updating.
- **`--insecure` flag**: every installer that hits the network defines an `INSECURE=''` variable set to
  `--insecure` when the flag is passed, then threads it through every `curl` call for corporate
  proxy/self-signed-cert environments. Follow this exact pattern (variable name, default empty, appended
  to curl args) when adding new network calls.
- **Command-line parsing**: a `parse_command_line_arguments()` function with a `while [[ $# -gt 0 ]]; do case $1 in ... esac; done` loop, unknown flags `echo` an error and `exit 1`. Reuse this shape for any new flags.
- **Colored progress banners**: `echo -e "\n\033[1;32m>>> <message>\033[0m\n"` (bold green) is used for all
  section banners/status messages — match this styling in new scripts.

### PowerShell script (`create-new-distro.ps1`)

Single sequential script (not modularized): unregisters any existing distro of the same name, installs a
fresh one via `wsl --install`, creates the Linux user, sets the password, grants sudo, writes
`/etc/wsl.conf` (`[user] default=...` + `[boot] systemd=true`), restarts WSL to apply it, then pipes the
remote `install-developer-tools.sh --all` into the new distro. Configuration (`$distroName`, `$linuxUser`,
`$linuxPass`, `$locationPath`) lives as plain variables at the top of the file and is meant to be
hand-edited before running — there's no CLI flag parsing here.
