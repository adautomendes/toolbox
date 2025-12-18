# JDK 21 + Maven + Gradle Installer (WSL/Ubuntu)

This folder provides a developer-friendly script to install and configure:

- OpenJDK 21 (21.0.2)
- Apache Maven (3.9.12) — only if not already installed
- Gradle (8.7) — only if not already installed

The script configures environment variables in your `~/.bashrc` and installs all tools under `~/Java/` to avoid requiring `sudo`.

---

## What It Does

- Downloads and extracts OpenJDK 21 to `~/Java/jdk21`.
- Appends `JAVA_HOME` and updates `PATH` in `~/.bashrc`.
- Installs Maven to `~/Java/maven` if `mvn` is not found, then appends `MAVEN_HOME` and updates `PATH`.
- Installs Gradle to `~/Java/gradle` if `gradle` is not found, then appends `GRADLE_HOME` and updates `PATH`.
- Prompts you to restart your terminal (or `source ~/.bashrc`).

---

## Prerequisites

- Linux or WSL (Ubuntu recommended)
- `wget`, `tar`, and `unzip` available on PATH
  - Install if missing:

```bash
sudo apt update
sudo apt install -y wget tar unzip
```

- Sufficient disk space in `~/Java/` (roughly 500–800 MB)

---

## Quick Start

From the repository root:

```bash
chmod +x wsl-ubuntu/developer-tools/java/install-jdk-21.sh
wsl-ubuntu/developer-tools/java/install-jdk-21.sh
# Apply environment changes to the current shell
source ~/.bashrc
```

Alternatively, run from within this folder:

```bash
chmod +x ./install-jdk-21.sh
./install-jdk-21.sh
source ~/.bashrc
```

---

## Installed Versions and Paths

- OpenJDK: 21.0.2 → `~/Java/jdk21`
- Maven: 3.9.12 → `~/Java/maven`
- Gradle: 8.7 → `~/Java/gradle`

Downloads are performed from official sources:

- OpenJDK: `https://download.java.net/.../openjdk-21.0.2_linux-x64_bin.tar.gz`
- Maven: `https://dlcdn.apache.org/maven/maven-3/3.9.12/.../apache-maven-3.9.12-bin.tar.gz`
- Gradle: `https://services.gradle.org/distributions/gradle-8.7-bin.zip`

---

## Environment Variables

The script appends the following to `~/.bashrc`:

```bash
# JDK 21 configuration
export JAVA_HOME=$HOME/Java/jdk21
export PATH=$JAVA_HOME/bin:$PATH

# Maven configuration (if Maven was installed)
export MAVEN_HOME=$HOME/Java/maven
export PATH=$MAVEN_HOME/bin:$PATH

# Gradle configuration (if Gradle was installed)
export GRADLE_HOME=$HOME/Java/gradle
export PATH=$GRADLE_HOME/bin:$PATH
```

These lines take effect on new shells; run `source ~/.bashrc` to apply immediately.

---

## Verify Installation

```bash
java -version
mvn -version
gradle -v
```

Expected outputs should show JDK 21.0.2, Maven 3.9.12, and Gradle 8.7.

---

## Re-running the Script (Idempotency)

- JDK is re-extracted each time; files under `~/Java/jdk21` are overwritten by extraction.
- Maven/Gradle are installed only if the `mvn`/`gradle` commands are not found.
- The script appends environment lines to `~/.bashrc` each run and does not deduplicate.
  - If you re-run often, consider removing duplicate lines from `~/.bashrc`.

---

## Customizing Versions

If you need different versions, edit the URLs and folder names in the script:

- JDK: change the OpenJDK download URL and the destination folder (e.g., `~/Java/jdkXX`).
- Maven: update the Maven tarball URL and version folder names.
- Gradle: update the distribution ZIP URL and version.

After edits, re-run the script and `source ~/.bashrc`.

---

## Uninstall / Cleanup

1. Remove installed directories:

```bash
rm -rf ~/Java/jdk21
rm -rf ~/Java/maven
rm -rf ~/Java/gradle
rm -f  ~/Java/openjdk-21_linux-x64_bin.tar.gz
rm -f  ~/Java/apache-maven-3.9.12-bin.tar.gz
rm -f  ~/Java/gradle-8.7-bin.zip
```

2. Edit `~/.bashrc` and remove the lines added under the comments:
   - `# JDK 21 configuration`
   - `# Maven configuration`
   - `# Gradle configuration`

3. Apply changes:

```bash
source ~/.bashrc
```

---

## Troubleshooting

- PATH not updated in current shell:
  - Run `source ~/.bashrc` or open a new terminal.
- `unzip: command not found`:
  - Install unzip: `sudo apt install -y unzip`.
- Duplicate PATH entries / repeated config lines:
  - Remove duplicate lines from `~/.bashrc`.
- Download failures (404 / slow network):
  - Try again later or check corporate proxy settings (`http_proxy`, `https_proxy`).
- Different architecture (ARM/Apple Silicon under virtualization):
  - Update the JDK download URL to the correct architecture build.

---

## License

This script is part of this repository and follows the repository's license. See [LICENSE](../../../LICENSE).
