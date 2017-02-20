#!/bin/bash

CA_NAME=localhost
CA_DN=/CN=${CA_NAME}
SERVER_NAME=localhost
SERVER_DN=/CN=${SERVER_NAME}
SERVER_IP=127.0.0.1

chmod 0770 /etc/docker
cd /etc/docker

if [ ! -f ca-key.pem -o ! -f ca.pem ]; then
    echo ""
    echo "######################################################################"
    echo "### Certificate authority"
    echo "###"
    set -e -x
    openssl genrsa -out ca-key.pem 4096
    openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem -subj "${CA_DN}"
    set +e +x
    echo ""
fi

if [ ! -f server-key.pem -o ! -f server-cert.pem ]; then
    echo ""
    echo "######################################################################"
    echo "### Server certificate"
    echo "###"
    set -e -x
    openssl genrsa -out server-key.pem 4096
    openssl req -subj "${SERVER_DN}" -sha256 -new -key server-key.pem -out server.csr
    echo "subjectAltName = DNS:${SERVER_NAME},IP:${SERVER_IP}" > extfile.cnf
    openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
    set +e +x
    echo ""
fi

if [ ! -f key.pem -o ! -f cert.pem ]; then
    echo ""
    echo "######################################################################"
    echo "### Client certificate"
    echo "###"
    set -e -x
    openssl genrsa -out key.pem 4096
    openssl req -subj '/CN=client' -new -key key.pem -out client.csr
    echo "extendedKeyUsage = clientAuth" > extfile.cnf
    openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
    set +e +x
    echo ""
fi


echo ""
echo "######################################################################"
echo "### Directory layout"
echo "###"
set -e -x
chmod 0640 *-key.pem
mkdir -p ~/.docker/machine/machines/${SERVER_NAME}
chmod 0750 ~/.docker
cp ca.pem cert.pem key.pem ~/.docker
cp ca.pem cert.pem key.pem ~/.docker/machine/machines/${SERVER_NAME}
set +e +x
echo ""