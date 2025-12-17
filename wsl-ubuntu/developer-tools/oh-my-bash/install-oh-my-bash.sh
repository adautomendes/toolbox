#!/bin/bash

# Install oh-my-bash
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo -e "\n\033[1;32m>>> Installing oh-my-bash...\033[0m\n"

    # Backup existing .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        cp "$HOME/.bashrc" "$HOME/.bashrc.backup_$(date +%Y%m%d%H%M%S)"
        echo "Backup of existing .bashrc created."
    fi

    curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh | bash

    # Set oh-my-bash theme to "powerline"
    sed -i 's/^OSH_THEME=.*/OSH_THEME="powerline"/' "$HOME/.bashrc"
fi