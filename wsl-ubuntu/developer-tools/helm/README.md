# Helm CLI Installer

Developer-focused notes for the Helm installer script in this directory.

## What this script does
- Fetches the latest Helm release tag from the official Helm GitHub repository.
- Downloads the matching `helm-<version>-linux-amd64.tar.gz` archive.
- Extracts it to `~/helm` and places the `helm` binary there.
- Adds `~/helm` to your PATH by appending to `~/.bashrc`.

## Prerequisites
- Linux amd64 environment (script downloads the linux-amd64 build).
- Tools: `curl`, `jq`, `tar`, `mv`, `rm`, `bash`.
- Network access to `https://api.github.com` and `https://get.helm.sh`.

## Usage
Run from any directory:

```bash
bash install-helm-cli.sh
```

### Optional flags
- `--insecure` — passes `--insecure` to `curl` for both API and binary downloads (use only if you understand the risk).

## What gets installed
- Helm binary: `~/helm/helm`
- PATH update: the script appends the following to `~/.bashrc` if not already present:
  - `# Helm configuration`
  - `export PATH=$PATH:$HOME/helm`

## Side effects
- Creates directory: `~/helm`
- Writes to: `~/.bashrc`
- Deletes temporary files under `~/helm` after extraction

## Verify installation
After opening a new shell (to pick up the PATH change):

```bash
helm version
```

Expected: a client version string matching the latest Helm release at install time.

## Re-run safety
- The script overwrites `~/helm/helm` with the latest binary each run.
- PATH lines may be duplicated if already present; you can manually deduplicate in `~/.bashrc` if needed.

## Uninstall
```bash
rm -rf ~/helm
# optionally remove the two lines the script appended from ~/.bashrc
```

## Troubleshooting
- If the version lookup fails, check network access to GitHub API and that `jq` is installed.
- If `helm` is not found after install, ensure a new shell session sourced the updated `~/.bashrc`.
