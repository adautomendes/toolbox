#!/bin/bash

INSECURE=''
INSTALL_OSH=false
INSTALL_NODEJS=false
INSTALL_DOCKER=false

parse_command_line_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --insecure)
                INSECURE='--insecure'
                shift
                ;;
            --osh)
                INSTALL_OSH=true
                shift
                ;;
            --nodejs)
                INSTALL_NODEJS=true
                shift
                ;;
            --docker)
                INSTALL_DOCKER=true
                shift
                ;;
            --all)
                INSTALL_OSH=true
                INSTALL_NODEJS=true
                INSTALL_DOCKER=true
                shift
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    echo -e "\n\033[1;32m>>> Provided options:\033[0m\n"
    echo -e "INSECURE: $INSECURE"
    echo -e "INSTALL_OSH: $INSTALL_OSH"
    echo -e "INSTALL_NODEJS: $INSTALL_NODEJS"
    echo -e "INSTALL_DOCKER: $INSTALL_DOCKER\n"
}

parse_command_line_arguments "$@"

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

if [ "$INSTALL_OSH" = true ]; then
    # Install oh-my-bash
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/oh-my-bash/install-oh-my-bash.sh | bash -s -- $INSECURE
fi

if [ "$INSTALL_NODEJS" = true ]; then
    # Install nodejs and npm via nvm
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh | bash -s -- $INSECURE
fi

if [ "$INSTALL_DOCKER" = true ]; then
    # Install Docker engine
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/docker/install-docker.sh | bash -s -- $INSECURE
fi

# Source .bashrc to apply changes
source $HOME/.bashrc

echo "Developer tools installation completed."
echo "Please restart your terminal..."