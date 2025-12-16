
# Monaspace Font Installation Script

## Overview
This README documents the `install-monaspace.sh` script, which automates the installation of the Monaspace font family on WSL Ubuntu systems.

## Purpose
The script downloads and installs the Monaspace fonts, a modern monospace font family designed for code editors and terminals, making them available system-wide.

## Features
- Automated font download and installation
- System-wide font availability
- WSL Ubuntu optimized
- Error handling and validation

## Usage
```bash
./install-monaspace.sh
```

## Requirements
- WSL (Windows Subsystem for Linux)
- Ubuntu distribution
- Internet connection
- Sufficient disk space

## Installation Steps
1. Make script executable: `chmod +x install-monaspace.sh`
2. Run the script: `./install-monaspace.sh`
3. Fonts will be installed to the system fonts directory

## Fonts Included
The Monaspace family includes:
- Monaspace Neon
- Monaspace Argon
- Monaspace Xenon
- Monaspace Radon

## Verification
After installation, verify fonts are available:
```bash
fc-list | grep -i monaspace
```

## Notes
- Administrative privileges may be required for system-wide installation
- Restart applications to apply new fonts
