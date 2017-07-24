FROM lukasgarcya/android-sdk-gcloud:android-sdk
MAINTAINER Lucas Garcia de Araújo Martins <lukasgarcya@hotmail.com>

# Install gradle
ADD https://services.gradle.org/distributions/gradle-4.0.1-bin.zip /opt
RUN unzip /opt/gradle-4.0.1-bin.zip -d /opt
RUN mv /opt/gradle-4.0.1 /opt/gradle
ENV PATH=/opt/gradle/bin:$PATH

# install Google Cloud SDK
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-stretch main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
ADD https://packages.cloud.google.com/apt/doc/apt-key.gpg /opt
RUN apt-key add /opt/apt-key.gpg
RUN apt-get update && apt-get -y install google-cloud-sdk

# Remove download files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /opt/gradle-4.0.1-bin.zip && \    
    rm -rf /opt/apt-key.gpg && \
    apt-get autoremove -y && \
    apt-get clean