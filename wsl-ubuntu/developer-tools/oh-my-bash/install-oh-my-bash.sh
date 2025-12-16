#!/bin/bash

# Install oh-my-bash
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo -e "\n\033[1;32m>>> Installing oh-my-bash...\033[0m\n"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    sed -i 's/^OSH_THEME=.*/OSH_THEME="lambda"/' "$HOME/.bashrc"
fi