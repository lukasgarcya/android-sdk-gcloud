FROM debian
MAINTAINER Lucas Garcia de Araújo Martins <lukasgarcya@hotmail.com>

# Install openjdk8 and bash to sdkmanager
RUN apt-get update
RUN apt-get -y install unzip openjdk-8-jdk lib32z1 lib32ncurses5 lib32stdc++6 git

# Create directory to Android SDK
RUN mkdir -p /opt/android-sdk-linux

# Download and extract Android SDK Tools
ADD https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip /opt
RUN unzip /opt/sdk-tools-linux-3859397.zip -d /opt/android-sdk-linux

# Set ANDROID_HOME
ENV ANDROID_HOME=/opt/android-sdk-linux

# Accepted Android SDK's license
RUN mkdir -p "$ANDROID_HOME/licenses"
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"

# Set PATH to Android SDK
ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/tools/bin:$PATH

# Android SDK configuration files
RUN mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings
RUN mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg

# Update Android SDK
RUN sdkmanager --update

# Install platforms;android-26
RUN sdkmanager "platforms;android-26"

# Install build-tools;26.0.0
RUN sdkmanager "build-tools;26.0.0"

# Install Android Support Repository
RUN sdkmanager "extras;android;m2repository"

# Install gradle
ADD https://services.gradle.org/distributions/gradle-4.0.1-bin.zip /opt
RUN unzip /opt/gradle-4.0.1-bin.zip -d /opt
RUN mv /opt/gradle-4.0.1 /opt/gradle
ENV PATH=/opt/gradle/bin:$PATH


