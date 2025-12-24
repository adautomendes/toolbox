# kubectl Installation Script

A bash script to automatically install the latest stable version of `kubectl` (Kubernetes command-line tool) on WSL Ubuntu/Linux systems.

## Description

This script downloads and installs the official `kubectl` binary from the Kubernetes release repository, configures it in your home directory, and automatically adds it to your system PATH for immediate use.

## Prerequisites

- WSL Ubuntu or any Linux distribution
- `curl` command-line tool
- Bash shell
- Internet connectivity to access Kubernetes release repository

## Installation

### Standard Installation

Run the script with default settings (uses secure HTTPS connections):

```bash
./install-kubectl.sh
```

### Installation Behind Corporate Proxy/Firewall

If you're behind a corporate proxy or experiencing SSL certificate issues, use the `--insecure` flag:

```bash
./install-kubectl.sh --insecure
```

> **⚠️ Warning**: The `--insecure` flag disables SSL certificate verification. Only use this option in controlled environments where you trust the network connection.

## Command-Line Options

| Option | Description |
|--------|-------------|
| `--insecure` | Passes the `--insecure` flag to curl commands, bypassing SSL certificate verification |

## What the Script Does

1. **Parses Command-Line Arguments**: Processes the `--insecure` flag if provided
2. **Creates Installation Directory**: Creates `$HOME/kubernetes` directory if it doesn't exist
3. **Downloads kubectl Binary**: 
   - Fetches the latest stable kubectl version number
   - Downloads the corresponding Linux AMD64 binary
4. **Sets Executable Permissions**: Makes the kubectl binary executable
5. **Configures PATH**: Appends kubectl configuration to `~/.bashrc` to ensure the binary is available in your PATH

## Installation Location

- **Binary Location**: `$HOME/kubernetes/kubectl`
- **Configuration File**: `~/.bashrc` (PATH modification)

## Post-Installation

### Activate the Installation

After running the script, reload your bash configuration:

```bash
source ~/.bashrc
```

Or simply restart your terminal session.

### Verify Installation

Check that kubectl is properly installed and accessible:

```bash
kubectl version --client
```

Expected output should show the kubectl client version information.

### Test Kubernetes Connectivity

If you have a Kubernetes cluster configured:

```bash
kubectl cluster-info
kubectl get nodes
```

## Configuration

### Kubernetes Cluster Setup

After installing kubectl, you'll need to configure access to your Kubernetes cluster:

1. **Copy kubeconfig file** (usually provided by your cluster administrator):
   ```bash
   mkdir -p ~/.kube
   cp /path/to/your/kubeconfig ~/.kube/config
   ```

2. **Or set the KUBECONFIG environment variable**:
   ```bash
   export KUBECONFIG=/path/to/your/kubeconfig
   ```

3. **Verify cluster access**:
   ```bash
   kubectl get nodes
   ```

## Troubleshooting

### kubectl command not found

If you receive a "command not found" error after installation:

1. Reload your bash configuration:
   ```bash
   source ~/.bashrc
   ```

2. Verify the PATH is set correctly:
   ```bash
   echo $PATH | grep kubernetes
   ```

3. Check if the binary exists:
   ```bash
   ls -la $HOME/kubernetes/kubectl
   ```

### SSL Certificate Verification Errors

If you encounter SSL certificate errors during download:

```bash
curl: (60) SSL certificate problem: unable to get local issuer certificate
```

**Solutions**:
- Use the `--insecure` flag (not recommended for production)
- Update your CA certificates:
  ```bash
  sudo apt-get update && sudo apt-get install -y ca-certificates
  ```
- Configure your corporate proxy certificates

### Permission Denied

If you get permission errors when running kubectl:

```bash
chmod +x $HOME/kubernetes/kubectl
```

### Old Version Installed

This script always downloads the latest stable version. To update:

1. Remove the old binary:
   ```bash
   rm $HOME/kubernetes/kubectl
   ```

2. Re-run the installation script

## Updating kubectl

To update to the latest version:

```bash
./install-kubectl.sh
```

The script will automatically download and replace the existing kubectl binary with the latest stable version.

## Uninstallation

To remove kubectl installed by this script:

1. Remove the binary:
   ```bash
   rm -rf $HOME/kubernetes
   ```

2. Remove the PATH configuration from `~/.bashrc`:
   ```bash
   # Manually edit ~/.bashrc and remove these lines:
   # # kubectl configuration
   # export PATH=$PATH:$HOME/kubernetes
   ```

3. Reload bash configuration:
   ```bash
   source ~/.bashrc
   ```

## Security Considerations

- The script downloads kubectl from the official Kubernetes release repository (`dl.k8s.io`)
- By default, curl verifies SSL certificates for secure downloads
- Only use the `--insecure` flag in trusted network environments
- Always verify the downloaded binary if security is a concern:
  ```bash
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  $HOME/kubernetes/kubectl" | sha256sum --check
  ```

## Additional Resources

- [Official kubectl Documentation](https://kubernetes.io/docs/reference/kubectl/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [kubectl Commands Reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [Kubernetes Official Releases](https://github.com/kubernetes/kubernetes/releases)

## License

This script is provided as-is for educational and development purposes.

## Contributing

Feel free to submit issues or pull requests to improve this installation script.

---

**Note**: This script is designed for development and testing environments. For production deployments, consider using your distribution's package manager or official Kubernetes deployment tools.
