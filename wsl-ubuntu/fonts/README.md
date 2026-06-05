# Font Installation Scripts

Scripts for installing developer-oriented fonts on WSL Ubuntu systems.

---

## install-github-monaspace.sh

Installs the [Monaspace](https://github.com/githubnext/monaspace) font family by GitHub Next.

### What it does

- Resolves the latest Monaspace release tag from the GitHub API.
- Downloads four font archives (frozen, nerdfonts, static, variable) from the GitHub release.
- Extracts all font files (`.ttf`, `.otf`, `.woff`, `.woff2`, `.eot`) and moves them to `~/.local/share/fonts/`.
- Runs `fc-cache` to update the system font cache.
- Cleans up the temporary working directory.

### Fonts included

- Monaspace Neon
- Monaspace Argon
- Monaspace Krypton
- Monaspace Radon
- Monaspace Xenon

All four distribution formats are installed: frozen (ligature-enabled), nerd fonts (icon-patched), static (OTF/TTF), and variable.

### Requirements

- WSL or native Ubuntu/Debian
- `curl`, `wget`, `jq`, `unzip`
- Internet access to `api.github.com` and `github.com`

### Usage

```bash
chmod +x install-github-monaspace.sh
./install-github-monaspace.sh
```

### Verify installation

```bash
fc-list | grep -i monaspace
```

Restart your terminal or IDE after installation to apply the new fonts.

---

## install-nerd-fonts.sh

Installs selected [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) patched with developer icons.

### What it does

- Resolves the latest Nerd Fonts release tag from the GitHub API.
- Downloads the following font packages from the release:
  - **FiraCode** — Fira Code with programming ligatures and Nerd Font icons
  - **UbuntuMono** — Ubuntu Mono with Nerd Font icons
- Extracts all font files and moves them to `~/.local/share/fonts/`.
- Runs `fc-cache` to update the system font cache.
- Cleans up the temporary working directory.

### Requirements

- WSL or native Ubuntu/Debian
- `curl`, `wget`, `jq`, `unzip`
- Internet access to `api.github.com` and `github.com`

### Usage

```bash
chmod +x install-nerd-fonts.sh
./install-nerd-fonts.sh
```

### Verify installation

```bash
fc-list | grep -i "FiraCode\|UbuntuMono"
```

Restart your terminal or IDE after installation to apply the new fonts.

---

## Notes

- Both scripts install fonts per-user under `~/.local/share/fonts/` and do not require `sudo`.
- Re-running a script will overwrite existing font files with the latest release version.
- If `fc-cache` is not found, update the font cache manually or install `fontconfig` (`sudo apt install fontconfig`).
