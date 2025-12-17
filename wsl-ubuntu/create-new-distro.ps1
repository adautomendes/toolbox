# --- Configuration ---
# Define the distro name, username, and password. Update it as needed.
$distroName = "Ubuntu_Test"
$linuxUser = "test"
$linuxPass = "test"
$locationPath = "C:\TEST_WSL\$distroName"

# --- Step 1: Clean up existing installation ---
Write-Host "Checking for existing $distroName installation..." -ForegroundColor Cyan

# Force unregister. We ignore errors (2>$null) in case it doesn't exist.
wsl --unregister $distroName 2>&1 | Out-Null

# --- Step 2: Install the Distro ---
Write-Host "Installing $distroName..." -ForegroundColor Cyan

# Create location folder if it doesn't exist
if (-not (Test-Path -Path $locationPath)) {
    New-Item -ItemType Directory -Path $locationPath | Out-Null
}
# --no-launch prevents the terminal window from popping up (requires newer WSL versions)
wsl --install Ubuntu --location $locationPath --name $distroName --no-launch

# Wait for registration to finalize in the background
Write-Host "Waiting for initialization..."
Start-Sleep -Seconds 5

# --- Step 3: Create User via Root Backdoor ---
Write-Host "Configuring credentials..." -ForegroundColor Cyan

# Create the user
wsl -d $distroName -u root useradd -m -s /bin/bash $linuxUser

# --- Step 4: Stdin the Password ---
# We wrap the command in 'bash -c' so the pipe happens entirely inside Linux.
# This bypasses the PowerShell UTF-16 encoding issue.
wsl -d $distroName -u root bash -c "echo '${linuxUser}:${linuxPass}' | chpasswd"

# --- Step 5: Grant Sudo Access ---
wsl -d $distroName -u root usermod -aG sudo $linuxUser

# --- Step 6: Set Default User ---
# This ensures that when you type 'wsl', you log in as your user, not root
$config = "[user]`ndefault=$linuxUser"
wsl -d $distroName -u root bash -c "echo '$config' > /etc/wsl.conf"

# --- Step 7: Restart to Apply Changes ---
wsl --terminate $distroName

# --- Step 8: Install Developer Tools ---
Write-Host "Installing developer tools..." -ForegroundColor Cyan
wsl -d $distroName -u $linuxUser bash -c "cd $HOME; curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | bash"

Write-Host "Success! $distroName has been re-installed and configured." -ForegroundColor Green
Write-Host "You can now run 'wsl -d $distroName' to login."