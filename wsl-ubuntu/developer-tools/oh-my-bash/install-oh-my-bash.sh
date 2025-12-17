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

# Install oh-my-bash
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo -e "\n\033[1;32m>>> Installing oh-my-bash...\033[0m\n"

    # Backup existing .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        cp "$HOME/.bashrc" "$HOME/.bashrc.backup_$(date +%Y%m%d%H%M%S)"
        echo "Backup of existing .bashrc created."
    fi

    curl -fsSL $INSECURE https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh | bash

    # Set oh-my-bash theme to "powerline"
    sed -i 's/^OSH_THEME=.*/OSH_THEME="powerline"/' "$HOME/.bashrc"
fi