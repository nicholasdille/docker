FROM ubuntu:xenial

ENV PROXY "http://10.12.1.236:8083"
ENV http_proxy=$PROXY \
    https_proxy=$PROXY

RUN apt-get update

ADD files /
RUN apt-get -y install dos2unix \
 && dos2unix /*.sh \
 && chmod 0755 /*.sh \
 && find /etc/apt/preferences.d/ -type f -print0 | xargs -0 -r chmod 0644