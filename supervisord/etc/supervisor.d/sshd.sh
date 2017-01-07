#!/bin/sh

rm -f /etc/ssh/ssh_host_*_key

ssh-keygen -t rsa     -N '' -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa     -N '' -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t ecdsa   -N '' -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key

exec /usr/sbin/sshd -D
