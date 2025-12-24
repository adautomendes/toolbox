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

# Install nodejs and npm via nvm
HELM_VERSION=$(curl -s $INSECURE https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name)

echo -e "\n\033[1;32m>>> Installing Helm version: $HELM_VERSION\033[0m\n"

mkdir -p $HOME/helm

curl -s $INSECURE -L -o $HOME/helm/helm-${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
tar -xzvf $HOME/helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -C $HOME/helm
mv $HOME/helm/linux-amd64/helm $HOME/helm/helm

rm -r $HOME/helm/linux-amd64
rm $HOME/helm/helm-${HELM_VERSION}-linux-amd64.tar.gz

# Append config to .bashrc
echo -e "\n# Helm configuration" >> $HOME/.bashrc
echo "export PATH=\$PATH:$HOME/helm" >> $HOME/.bashrc