#!/bin/bash

# Install pipx
if ! command -v pipx &> /dev/null; then
    echo -e "\n\033[1;32m>>> Installing pipx...\033[0m\n"

    sudo apt install pipx -y
    pipx ensurepath
    sudo pipx ensurepath --global

    echo -e "\n\033[1;32m>>> pipx installation completed!\033[0m\n"

    # Install virtualenv using pipx
    echo -e "\n\033[1;32m>>> Installing virtualenv using pipx...\033[0m\n"

    pipx install virtualenv

    mkdir -p $HOME/Python

    virtualenv $HOME/Python/env
    
    echo -e "\n\033[1;32m>>> virtualenv created at $HOME/Python/env\033[0m\n"
    echo -e "\n\033[1;32m>>> virtualenv installation completed!\033[0m\n"
fi