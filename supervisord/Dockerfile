FROM alpine:3.4

ENV SSH_USER "admin"

RUN apk update \
 && apk upgrade \
 && apk add sudo ca-certificates wget supervisor dcron openssh
ADD etc /etc/

RUN adduser -D "${SSH_USER}" \
 && echo "${SSH_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${SSH_USER} \
 && mkdir -p /home/${SSH_USER}/.ssh \
 && wget -qO /home/${SSH_USER}/.ssh/authorized_keys "https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub" \
 && chown admin /home/${SSH_USER}/.ssh/authorized_keys

ENTRYPOINT [ "supervisord" ]
CMD [ "-c", "/etc/supervisord.conf" ]
