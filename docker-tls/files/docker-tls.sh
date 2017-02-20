#!/bin/bash

echo ""
echo "######################################################################"
echo "### Certificate authority"
echo "###"
set -e -x
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem -subj "${CA_DN}"
set +e +x
echo ""

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

echo ""
echo "######################################################################"
echo "### Directory layout"
echo "###"
set -e -x
mkdir -p /tmp/docker-tls/server /tmp/docker-tls/client /tmp/docker-tls/client/.docker/machine/machine/${SERVER_NAME}
cp {ca,cert,key}.pem /tmp/docker-tls/client
cp /tmp/docker-tls/client/*.pem /tmp/docker-tls/client/.docker/machine/machine/${SERVER_NAME}
cp {ca,server-cert,server-key}.pem /tmp/docker-tls/server
set +e +x
echo ""
