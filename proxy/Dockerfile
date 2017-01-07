FROM centos:7

ARG PROXY

ENV PROXY=$PROXY

ADD proxy.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/proxy.sh