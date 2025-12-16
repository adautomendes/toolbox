apt_packages=(
    snapd
    curl
    tree
    yq
    jq
    git
    wget
    build-essential
    python3
    python3-pip
)

# Update/Upgrade packages
sudo apt update && sudo apt upgrade -y

# Install apt packages
sudo apt install -y "${apt_packages[@]}"

# Install oh-my-zsh
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-oh-my-zsh.sh | bash

# Install nodejs and npm via nvm
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-nodejs.sh | bash

# Install Docker engine
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-docker.sh | bash


echo "Developer tools installation completed."
echo "Please restart your terminal..."