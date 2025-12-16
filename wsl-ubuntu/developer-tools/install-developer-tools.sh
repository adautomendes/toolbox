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


# Install nodejs and npm via nvm


# Install Docker engine


echo "Developer tools installation completed."
echo "Please restart your terminal..."