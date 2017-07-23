FROM alpine
RUN apk --update add openjdk8 wget
RUN mkdir -p /opt/android-sdk-linux
ADD https://dl.google.com/android/repository/tools_r25.2.3-linux.zip /opt
RUN unzip /opt/tools_r25.2.3-linux.zip -d /opt/android-sdk-linux
ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux
RUN mkdir -p "$ANDROID_HOME/licenses"
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
RUN echo $PATH
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository,extra-android-m2repository
RUN mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings
RUN mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg
