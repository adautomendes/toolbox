#!/bin/bash

# Install JDK 21
if ! command -v java &> /dev/null; then
    JAVA_VERSION=21.0.2

    echo -e "\n\033[1;32m>>> Installing JDK 21...\033[0m\n"

    mkdir -p $HOME/Java/jdk21

    wget https://download.java.net/java/GA/jdk${JAVA_VERSION}/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz -O $HOME/Java/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz

    tar -xzf $HOME/Java/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz -C $HOME/Java/jdk21 --strip-components=1

    # Append JAVA_HOME to .bashrc
    echo -e "\n\n# JDK 21 configuration" >> $HOME/.bashrc
    echo "export JAVA_HOME=$HOME/Java/jdk21" >> $HOME/.bashrc
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $HOME/.bashrc

    # Print success message
    echo -e "\n\033[1;32m>>> JDK 21 installation completed!\033[0m\n"
fi

# Install Maven
if ! command -v mvn &> /dev/null; then
    MAVEN_VERSION=$(curl -s https://dlcdn.apache.org/maven/maven-3/ | grep -oP 'href="\K3\.\d+\.\d+(?=/")' | sort -V | tail -n 1)

    echo -e "\n\033[1;32m>>> Installing Maven...\033[0m\n"

    mkdir -p $HOME/Java/maven

    wget https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O $HOME/Java/apache-maven-$MAVEN_VERSION-bin.tar.gz

    tar -xzf $HOME/Java/apache-maven-$MAVEN_VERSION-bin.tar.gz -C $HOME/Java/maven --strip-components=1

    # Append M2_HOME to .bashrc
    echo -e "\n# Maven configuration" >> $HOME/.bashrc
    echo "export M2_HOME=$HOME/Java/maven" >> $HOME/.bashrc
    echo "export PATH=\$M2_HOME/bin:\$PATH" >> $HOME/.bashrc

    # Print success message
    echo -e "\n\033[1;32m>>> Maven installation completed!\033[0m\n"
fi

# Install Gradle
if ! command -v gradle &> /dev/null; then
    GRADLE_VERSION=8.7

    echo -e "\n\033[1;32m>>> Installing Gradle...\033[0m\n"

    wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -O $HOME/Java/gradle-$GRADLE_VERSION-bin.zip

    unzip -q $HOME/Java/gradle-$GRADLE_VERSION-bin.zip -d $HOME/Java

    mv $HOME/Java/gradle-$GRADLE_VERSION $HOME/Java/gradle

    # Append GRADLE_HOME to .bashrc
    echo -e "\n# Gradle configuration" >> $HOME/.bashrc
    echo "export GRADLE_HOME=$HOME/Java/gradle" >> $HOME/.bashrc
    echo "export PATH=\$GRADLE_HOME/bin:\$PATH" >> $HOME/.bashrc

    # Print success message
    echo -e "\n\033[1;32m>>> Gradle installation completed!\033[0m\n"
fi

echo -e "\033[1;32m>>> Please restart your terminal...\033[0m\n"