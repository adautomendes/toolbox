# Install Virtualenv Script

This script automates the installation of `pipx` and `virtualenv` on a Linux system. It ensures that the necessary tools are installed and configured correctly for Python virtual environment management.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Prerequisites
- A Linux-based operating system.
- `sudo` privileges to install packages.
- Python should be installed on your system.

## Installation
1. Clone the repository or download the script.
2. Open a terminal and navigate to the directory containing the script.
3. Run the script using the following command:
   ```bash
   bash install-virtualenv.sh
   ```

## Script Overview
- **pipx Installation**: The script checks if `pipx` is installed. If not, it installs `pipx` using the package manager.
- **Ensure Path**: It ensures that `pipx` is added to the system's PATH.
- **virtualenv Installation**: After installing `pipx`, it uses `pipx` to install `virtualenv`.

## Usage
After running the script, you can create a new virtual environment using:
```bash
virtualenv <env_name>
```
Replace `<env_name>` with your desired environment name.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
