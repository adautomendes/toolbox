#!/bin/zsh

# wsl --unregister Ubuntu_Test; wsl --install Ubuntu-24.04 --location . --name Ubuntu_Test
# cd $HOME; curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/install-developer-tools.sh | zsh

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

echo -e "\n\033[1;32m>>> Installing developer tools...\033[0m\n"

# Update/Upgrade packages
sudo apt update && sudo apt upgrade -y

# Install apt packages
echo -e "\n\033[1;32m>>> Installing apt packages...\033[0m\n"
echo -e "\n\033[1;32m>>> Packages to install: ${apt_packages[*]}\033[0m\n"
sudo apt install -y "${apt_packages[@]}"

# Clean up
sudo apt autoremove -y

# Install oh-my-zsh
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/oh-my-zsh/install-oh-my-zsh.sh | zsh

# Install nodejs and npm via nvm
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh | zsh

# Install Docker engine
curl -o- https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/docker/install-docker.sh | zsh


echo "Developer tools installation completed."
echo "Please restart your terminal..."