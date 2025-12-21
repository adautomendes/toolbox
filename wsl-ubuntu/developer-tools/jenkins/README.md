# Jenkins on WSL (Ubuntu)

## Overview
Scripts to set up a local Jenkins instance on WSL and optionally preconfigure Maven and Gradle tool installations inside Jenkins.

## Scripts
- install: [install-jenkins.sh](install-jenkins.sh)
- configure tools: [configure-jenkins-tools.sh](configure-jenkins-tools.sh)

## What the installer does
- Creates the Jenkins home directory at `$HOME/Jenkins/home`.
- Downloads the latest `jenkins.war` from get.jenkins.io into `$HOME/Jenkins/jenkins.war`.
- Appends Jenkins config to `~/.bashrc`:
  - Exports `JENKINS_HOME=$HOME/Jenkins/home`.
  - Adds alias `jenkins-run` that starts Jenkins with the chosen HTTP port.
- Prints run instructions and endpoint URL.

## Requirements
- Bash, `wget`.
- Java Runtime Environment on PATH (used by `java -jar jenkins.war`).
- Permission to write to `~/.bashrc` and `$HOME/Jenkins`.

## Install Jenkins
```bash
cd wsl-ubuntu/developer-tools/jenkins
./install-jenkins.sh [port]
```
- `port` (optional): HTTP port to bind; defaults to `9000`.

After the script completes, restart the terminal so the alias and env variable load.

## Run Jenkins
```bash
jenkins-run
```
- Opens Jenkins at `http://localhost:<port>` using the port provided during installation.
- Jenkins data persists under `$HOME/Jenkins/home`.

---

## Configure Jenkins Tools (Maven/Gradle)
The optional configurator writes Jenkins tool definitions pointing to local Maven/Gradle installs, so pipelines can select them by name without manual UI setup.

### What it does
- Writes `$JENKINS_HOME/hudson.tasks.Maven.xml` with a Maven installation named `maven3` at `$HOME/Java/maven`.
- Writes `$JENKINS_HOME/hudson.plugins.gradle.Gradle.xml` with a Gradle installation named `gradle8` at `$HOME/Java/gradle`.
- Uses `$JENKINS_HOME=$HOME/Jenkins/home` (same location created by the installer).

### Additional requirements
- Maven installed under `$HOME/Java/maven` and/or Gradle under `$HOME/Java/gradle`.
  - If your paths differ, update the script or the generated XML accordingly.

### Usage
```bash
cd wsl-ubuntu/developer-tools/jenkins
./configure-jenkins-tools.sh
```

Then restart Jenkins (stop the current process and run `jenkins-run` again) so Jenkins reloads the tool definitions.

## Notes
- Re-run the installer to update the WAR file or to change the default port alias.
- To change the port without reinstalling, edit the `jenkins-run` alias in `~/.bashrc` and reload your shell.
- If you keep Jenkins running while writing the XML files, tools will appear after the next Jenkins restart.
