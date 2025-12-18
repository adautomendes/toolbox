# WSL Ubuntu Distribution Creator

Automated PowerShell script to create and configure custom WSL Ubuntu distributions with pre-installed developer tools.

## Overview

This script provides a streamlined way to create fresh WSL Ubuntu installations with automatic user configuration and developer tooling. It handles the complete setup process from distro installation to development environment configuration in a single execution.

## Features

- 🔄 **Automated Installation**: Creates WSL Ubuntu distro with custom name and location
- 👤 **User Configuration**: Sets up custom Linux user with specified credentials
- 🔐 **Security Setup**: Automatically grants sudo privileges to the created user
- 🛠️ **Developer Tools**: Installs development tools via automated bootstrap script
- 🧹 **Clean Installation**: Removes existing distro before installation to ensure fresh setup
- ⚙️ **Default User**: Configures the distro to login with your user by default (not root)

## Prerequisites

- **Windows 10/11** with WSL2 enabled
- **PowerShell 5.1+**
- **Internet Connection** for downloading Ubuntu and developer tools
- **WSL Feature Enabled**: Run `wsl --install` if WSL is not yet installed

## Configuration

Edit the configuration variables at the top of the script before running:

```powershell
$distroName = "My_Aweosome_Ubuntu"  # Name of the WSL distribution
$linuxUser = "user"                  # Linux username to create
$linuxPass = "user"                  # Password for the Linux user
$locationPath = "C:\WSL\$distroName" # Installation directory
```

### Configuration Parameters

| Parameter | Description | Default Value | Notes |
|-----------|-------------|---------------|-------|
| `$distroName` | WSL distribution name | `My_Aweosome_Ubuntu` | Must be unique; underscores recommended |
| `$linuxUser` | Linux username | `user` | Will be created with home directory |
| `$linuxPass` | User password | `user` | Used for sudo operations |
| `$locationPath` | Installation path | `C:\WSL\$distroName` | Directory will be created if missing |

## Usage

### Basic Usage

1. **Open PowerShell as Administrator**
2. **Navigate to the script directory**:
   ```powershell
   cd C:\path\to\toolbox\wsl-ubuntu
   ```
3. **Execute the script**:
   ```powershell
   .\create-new-distro.ps1
   ```

### Access Your Distro

After installation completes:

```powershell
# Launch the distro
wsl -d My_Aweosome_Ubuntu

# Or set it as default
wsl --set-default My_Aweosome_Ubuntu
wsl
```

## What the Script Does

The script executes the following steps in sequence:

### Step 1: Cleanup Existing Installation
- Checks for existing distro with the same name
- Unregisters the old distro if found **(data will be lost)**
- Prevents conflicts with previous installations

### Step 2: Install Ubuntu Distribution
- Creates the installation directory if needed
- Downloads and installs Ubuntu from Microsoft Store
- Uses `--no-launch` flag to prevent automatic terminal popup
- Waits for background initialization (5 seconds)

### Step 3: Create Linux User
- Executes as root to create new user account
- Creates home directory at `/home/$linuxUser`
- Sets default shell to `/bin/bash`

### Step 4: Set User Password
- Uses `chpasswd` command to set password securely
- Handles password encoding correctly through bash pipe
- Avoids PowerShell UTF-16 encoding issues

### Step 5: Grant Sudo Access
- Adds user to `sudo` group
- Enables passwordless (or password-protected) sudo operations

### Step 6: Configure Default User
- Creates `/etc/wsl.conf` with user configuration
- Ensures the custom user logs in by default (not root)
- Improves security and user experience

### Step 7: Apply Configuration
- Terminates the distro to reload settings
- Forces WSL to read the new `/etc/wsl.conf`

### Step 8: Install Developer Tools
- Downloads and executes the developer tools installation script
- Runs from the user's home directory
- Installs tools based on `--all` flag (see Developer Tools section)

## Developer Tools Installation

The script automatically installs development tools via the bootstrap script from this repository:

```bash
https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh
```

### Available Tools

Based on the repository structure, the following tools may be installed:

- **Docker**: Container runtime and CLI
- **Java**: JDK 21
- **Jenkins**: CI/CD automation server
- **Node.js**: JavaScript runtime and npm
- **Oh My Bash**: Enhanced bash shell with themes and plugins
- **Python**: Virtual environment tools
- **Fonts**: Monaspace font family

For detailed information about each tool installation, refer to the respective README files in the `developer-tools/` directory.

## Troubleshooting

### Script Requires Administrator Privileges

**Error**: `Access denied` or permission errors

**Solution**: Right-click PowerShell and select "Run as Administrator"

### WSL Not Installed

**Error**: `wsl : The term 'wsl' is not recognized`

**Solution**: 
```powershell
wsl --install
# Restart your computer after installation
```

### Distribution Already Exists

**Note**: The script automatically unregisters existing distros with the same name. All data in the old distro will be lost. Backup important data before running.

### Network Issues During Tool Installation

**Error**: Tools fail to download or install

**Solution**: 
1. Check internet connection
2. Verify GitHub repository URL is accessible
3. Re-run the script - it will attempt installation again

### Distro Won't Start

**Error**: Distro hangs or fails to start

**Solution**:
```powershell
# Check WSL version
wsl --version

# Update WSL
wsl --update

# Check distro status
wsl --list --verbose

# Try manual termination and restart
wsl --terminate My_Aweosome_Ubuntu
wsl -d My_Aweosome_Ubuntu
```

### Password Not Working

**Issue**: Cannot sudo or login with specified password

**Solution**: Re-run the script. The password encoding step uses bash pipe to avoid encoding issues.

## Security Considerations

⚠️ **Important Security Notes**:

1. **Plaintext Passwords**: The script contains passwords in plaintext. Consider:
   - Using a temporary password and changing it after first login
   - Restricting script file permissions
   - Not committing your customized script to version control

2. **Sudo Access**: The created user has sudo privileges. Ensure:
   - Use strong passwords in production environments
   - Consider passwordless sudo only for development machines

3. **Automatic Tool Installation**: The script downloads and executes remote code. Verify:
   - Repository authenticity (currently points to `adautomendes/toolbox`)
   - Network security when downloading tools

## Advanced Usage

### Custom Tool Installation

To skip automatic tool installation, comment out Step 8:

```powershell
# Write-Host "Installing developer tools..." -ForegroundColor Cyan
# wsl -d $distroName -u $linuxUser bash -c "cd $HOME; curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash -s -- --all"
```

## Contributing

To modify or extend the script:

1. Fork the repository
2. Make your changes
3. Test thoroughly on a clean Windows installation
4. Submit a pull request with detailed description

## License

See the [LICENSE](../LICENSE) file in the root of the repository.

## Support

For issues, questions, or contributions:
- Review existing issues in the repository
- Check the troubleshooting section above
- Open a new issue with detailed information about your problem

## Changelog

### Current Version
- Initial release with automated Ubuntu WSL setup
- Automatic user configuration
- Integrated developer tools installation
- Clean installation workflow

## Related Documentation

- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Developer Tools README](developer-tools/README.md)
- [Docker Installation Guide](developer-tools/docker/README.md)
- [Python Tools README](developer-tools/python/README.md)

---

**Last Updated**: December 2025  
**Maintained by**: Repository Contributors
