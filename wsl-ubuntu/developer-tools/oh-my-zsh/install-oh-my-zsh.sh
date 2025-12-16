#!/bin/bash

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "\n\033[1;32m>>> Installing oh-my-zsh...\033[0m\n"
    sudo apt install -y zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo chsh -s $(which zsh) $(whoami)
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo -e "\n\033[1;32m>>> Installing Powerlevel10k theme...\033[0m\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Set ZSH_THEME="powerlevel10k/powerlevel10k" in .zshrc if not already set
if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$HOME/.zshrc"; then
    echo -e "\n\033[1;32m>>> Configuring .zshrc to use Powerlevel10k theme...\033[0m\n"
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! $HOME/.zshrc
fi