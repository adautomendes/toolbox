#!/bin/bash

port=${1:-9000}

echo -e "\n\033[1;32m>>> Installing Jenkins...\033[0m\n"

# Create Jenkins folders
mkdir -p $HOME/Jenkins/home

# Download Jenkins latest war file
curl -L -o $HOME/Jenkins/jenkins.war https://get.jenkins.io/war/latest/jenkins.war

# Append config to .bashrc
echo -e "\n# Jenkins configuration" >> $HOME/.bashrc
echo "export JENKINS_HOME=$HOME/Jenkins/home" >> $HOME/.bashrc
echo "alias jenkins-run=\"java -jar $HOME/Jenkins/jenkins.war --httpPort=$port\"" >> $HOME/.bashrc

# Print success message
echo -e "\n\033[1;32m>>> Jenkins installation completed!\033[0m\n"
echo -e "\033[1;32m>>> Please restart your terminal...\033[0m\n"
echo -e "\033[1;32m>>> To run Jenkins, use the command: jenkins-run\033[0m\n"
echo -e "\033[1;32m>>> Access Jenkins at: http://localhost:$port\033[0m\n"