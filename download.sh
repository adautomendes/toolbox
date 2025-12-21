TARGET="/mnt/c/Adauto/downloads"

wget https://get.jenkins.io/war/latest/jenkins.war -O $TARGET/jenkins.war
wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz -O $TARGET/openjdk-21.0.2_linux-x64_bin.tar.gz
wget https://dlcdn.apache.org/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz -O $TARGET/apache-maven-3.9.12-bin.tar.gz
wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -O $TARGET/gradle-8.7-bin.zip