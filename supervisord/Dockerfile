FROM ubuntu:xenial

RUN apt-get update \
 && apt-get -y install apt-utils \
 && apt-get -y install ca-certificates wget curl supervisor sudo

ADD etc /etc/

ENTRYPOINT [ "supervisord" ]
CMD [ "-c", "/etc/supervisord.conf" ]
