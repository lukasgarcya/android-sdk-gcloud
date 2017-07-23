FROM alpine
ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux
ADD https://dl.google.com/android/repository/tools_r25.2.3-linux.zip /opt
RUN apk --update add openjdk8 wget bash \
mkdir -p /opt/android-sdk-linux \
unzip /opt/tools_r25.2.3-linux.zip -d /opt/android-sdk-linux \
mkdir -p "$ANDROID_HOME/licenses" \
echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" \
echo y | android update sdk --no-ui --all --filter extra-google-m2repository,extra-android-m2repository \
mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings \
mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg
