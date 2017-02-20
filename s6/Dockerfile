FROM ubuntu:xenial

SHELL [ "bash", "-e", "-x", "-c" ]

RUN apt-get update \
 && apt-get -y install cron dos2unix

ADD s6-bin.tar.gz /
ADD files /

RUN find /etc/s6 -type f | xargs -r -n 1 dos2unix

ENTRYPOINT [ "s6-svscan" ]
CMD [ "/etc/s6/services" ]
