FROM alpine

RUN apk --update add openjdk8 wget bash

RUN mkdir -p /var/opt/android-sdk-linux
ADD https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip /var/opt
RUN unzip /var/opt/sdk-tools-linux-3859397.zip -d /var/opt/android-sdk-linux
ENV ANDROID_HOME=/var/opt/android-sdk-linux
RUN mkdir -p "$ANDROID_HOME/licenses"
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
ENV PATH=/var/opt/android-sdk-linux/platform-tools:/var/opt/android-sdk-linux/tools:/var/opt/android-sdk-linux/tools/bin:$PATH
RUN mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings
RUN mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg
RUN sdkmanager --update

ADD https://services.gradle.org/distributions/gradle-3.3-bin.zip /var/opt
RUN unzip /var/opt/gradle-3.3-bin.zip -d /var/opt
RUN mv /var/opt/gradle-3.3 /var/opt/gradle
ENV PATH=/var/opt/gradle/bin:$PATH


