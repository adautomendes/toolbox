#!/bin/bash

INSECURE=''
INSTALL_OSH=false
INSTALL_JAVA21=false
INSTALL_PYTHON=false
INSTALL_NODEJS=false
INSTALL_DOCKER=false
INSTALL_KUBECTL=false
INSTALL_HELM=false
INSTALL_JENKINS=false

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
            --java21)
                INSTALL_JAVA21=true
                shift
                ;;
            --python)
                INSTALL_PYTHON=true
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
            --kubectl)
                INSTALL_KUBECTL=true
                shift
                ;;
            --helm)
                INSTALL_HELM=true
                shift
                ;;
            --jenkins)
                INSTALL_JENKINS=true
                shift
                ;;
            --all)
                INSTALL_OSH=true
                INSTALL_JAVA21=true
                INSTALL_PYTHON=true
                INSTALL_NODEJS=true
                INSTALL_DOCKER=true
                INSTALL_KUBECTL=true
                INSTALL_HELM=true
                INSTALL_JENKINS=true
                shift
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    echo -e "\n\033[1;32m>>> Provided options:\033[0m"
    echo -e "\033[1;32m - INSECURE: $INSECURE\033[0m"
    echo -e "\033[1;32m - INSTALL_OSH: $INSTALL_OSH\033[0m"
    echo -e "\033[1;32m - INSTALL_JAVA21: $INSTALL_JAVA21\033[0m"
    echo -e "\033[1;32m - INSTALL_PYTHON: $INSTALL_PYTHON\033[0m"
    echo -e "\033[1;32m - INSTALL_NODEJS: $INSTALL_NODEJS\033[0m"
    echo -e "\033[1;32m - INSTALL_DOCKER: $INSTALL_DOCKER\033[0m"
    echo -e "\033[1;32m - INSTALL_KUBECTL: $INSTALL_KUBECTL\033[0m"
    echo -e "\033[1;32m - INSTALL_HELM: $INSTALL_HELM\033[0m"
    echo -e "\033[1;32m - INSTALL_JENKINS: $INSTALL_JENKINS\033[0m\n"
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
    unzip
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

if [ "$INSTALL_JAVA21" = true ]; then
    # Install JDK 21, Maven and Gradle
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/java/install-jdk-21.sh | bash
fi

if [ "$INSTALL_PYTHON" = true ]; then
    # Install Python tools
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/python/install-virtualenv.sh | bash
fi

if [ "$INSTALL_NODEJS" = true ]; then
    # Install nodejs and npm via nvm
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/nodejs/install-nodejs.sh | bash -s -- $INSECURE
fi

if [ "$INSTALL_DOCKER" = true ]; then
    # Install Docker engine
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/docker/install-docker.sh | bash
fi

if [ "$INSTALL_KUBECTL" = true ]; then
    # Install kubectl
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/kubernetes/install-kubectl.sh | bash -s -- $INSECURE
fi

if [ "$INSTALL_HELM" = true ]; then
    # Install Helm
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/kubernetes/install-helm.sh | bash -s -- $INSECURE
fi

if [ "$INSTALL_JENKINS" = true ]; then
    # Install Jenkins
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/install-jenkins.sh | bash
fi

# If Java and Jenkins are installed, configure Maven/Gradle for Jenkins
if [ "$INSTALL_JAVA21" = true ] && [ "$INSTALL_JENKINS" = true ]; then
    echo -e "\n\033[1;32m>>> Configuring Maven and Gradle for Jenkins...\033[0m\n"

    # Configure Jenkins tools (Maven/Gradle)
    curl -o- $INSECURE https://raw.githubusercontent.com/adautomendes/toolbox/refs/heads/main/wsl-ubuntu/developer-tools/jenkins/configure-jenkins-tools.sh | bash

    echo -e "\n\033[1;32m>>> Maven and Gradle configuration for Jenkins completed!\033[0m\n"
fi

touch $HOME/.hushlogin

echo -e "\n\033[1;32m>>> Developer tools installation completed!\033[0m\n"
echo -e "\033[1;32m>>> Please restart your terminal...\033[0m\n"