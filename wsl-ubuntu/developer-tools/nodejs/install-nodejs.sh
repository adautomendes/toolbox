#!/usr/bin/env bash

INSECURE=''

parse_command_line_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --insecure)
                INSECURE='--insecure'
                shift
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    echo -e "\n\033[1;32m>>> Provided options: $INSECURE\033[0m\n"
}

parse_command_line_arguments "$@"

# Install nodejs and npm via nvm
NVM_VERSION=$(curl -s $INSECURE https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r .tag_name)

if [ ! -d "$HOME/.nvm" ]; then
    echo -e "\n\033[1;32m>>> Installing nvm version: $NVM_VERSION\033[0m\n"
    curl -o- $INSECURE https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
fi