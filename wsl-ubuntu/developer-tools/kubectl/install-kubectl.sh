#!/bin/bash

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

echo -e "\n\033[1;32m>>> Installing kubectl...\033[0m\n"

mkdir -p $HOME/kubernetes

curl $INSECURE -LO -o "$HOME/kubernetes/kubectl" "https://dl.k8s.io/release/$(curl $INSECURE -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x $HOME/kubernetes/kubectl

# Append config to .bashrc
echo -e "\n# kubectl configuration" >> $HOME/.bashrc
echo "export PATH=\$PATH:$HOME/kubernetes" >> $HOME/.bashrc