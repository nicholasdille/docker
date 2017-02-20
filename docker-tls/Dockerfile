FROM ubuntu:xenial

SHELL [ "bash", "-e", "-x", "-c" ]

RUN apt-get update \
 && apt-get -y install openssl dos2unix

ENV CA_NAME="localhost" \
    SERVER_NAME="localhost" \
    SERVER_IP="127.0.0.1"
ENV CA_DN="/CN=${CA_NAME}" \
    SERVER_DN="/CN=${SERVER_NAME}"

ADD files /
RUN dos2unix /docker-tls.sh \
 && chmod +x /docker-tls.sh

VOLUME /tmp/docker-tls
ENTRYPOINT /docker-tls.sh