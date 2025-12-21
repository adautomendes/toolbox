#!/bin/bash

echo -e "\n\033[1;32m>>> Configuring Jenkins tools (Maven/Gradle)...\033[0m\n"

JENKINS_HOME=$HOME/Jenkins/home

cat <<EOL >> $JENKINS_HOME/hudson.tasks.Maven.xml
<?xml version='1.1' encoding='UTF-8'?>
<hudson.tasks.Maven_-DescriptorImpl>
  <installations>
    <hudson.tasks.Maven_-MavenInstallation>
      <name>maven3</name>
      <home>$HOME/Java/maven</home>
      <properties/>
    </hudson.tasks.Maven_-MavenInstallation>
  </installations>
</hudson.tasks.Maven_-DescriptorImpl>
EOL

cat <<EOL >> $JENKINS_HOME/hudson.plugins.gradle.Gradle.xml
<?xml version='1.1' encoding='UTF-8'?>
<hudson.plugins.gradle.Gradle_-DescriptorImpl>
  <installations>
    <hudson.plugins.gradle.GradleInstallation>
      <name>gradle8</name>
      <home>$HOME/Java/gradle</home>
      <properties/>
      <gradleHome>$HOME/Java/gradle</gradleHome>
    </hudson.plugins.gradle.GradleInstallation>
  </installations>
</hudson.plugins.gradle.Gradle_-DescriptorImpl>
EOL