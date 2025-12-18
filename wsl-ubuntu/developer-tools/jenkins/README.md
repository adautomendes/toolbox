# Jenkins Installer (WSL)

## Overview
Automation script to set up a local Jenkins instance on WSL by downloading the latest Jenkins WAR and wiring a convenient launch alias.

## Script
- [wsl-ubuntu/developer-tools/jenkins/install-jenkins.sh](install-jenkins.sh)

## What it does
- Creates the Jenkins home directory at `$HOME/Jenkins/home`.
- Downloads the latest `jenkins.war` from get.jenkins.io into `$HOME/Jenkins/jenkins.war`.
- Appends Jenkins config to `~/.bashrc`:
  - `JENKINS_HOME` pointing to the created home directory.
  - Alias `jenkins-run` that starts Jenkins with the chosen HTTP port.
- Prints run instructions and endpoint URL.

## Requirements
- Bash, `curl`.
- Java Runtime Environment available on PATH (required for `java -jar jenkins.war`).
- Permission to write to `~/.bashrc` and `$HOME/Jenkins`.

## Usage
```bash
cd wsl-ubuntu/developer-tools/jenkins
./install-jenkins.sh [port]
```
- `port` (optional): HTTP port to bind; defaults to `9000`.

After the script completes, **restart the terminal** so the alias and env variable load.

## Running Jenkins
```bash
jenkins-run
```
- Opens Jenkins at `http://localhost:<port>` using the port provided during installation.
- Jenkins data persists under `$HOME/Jenkins/home`.

## Notes
- Re-run the installer to update the WAR or change the default port alias.
- If you prefer another port later, edit the `jenkins-run` alias in `~/.bashrc` and reload the shell.
