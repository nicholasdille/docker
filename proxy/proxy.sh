#!/bin/sh

if [ ! -z "$PROXY" ]
then
        export HTTP_PROXY=$PROXY
        export HTTPS_PROXY=$PROXY
        export http_proxy=$PROXY
        export https_proxy=$PROXY

        cat /etc/*-release | eval

        if [ "$ID_LIKE" == "debian" ]
        then
                cat > /etc/apt/apt.conf.d/01proxy < EOF
Acquire::http::proxy "$PROXY";
Acquire::https::proxy "$PROXY";
EOF
        fi

        mkdir ~/.gradle
        cat > ~/.gradle/gradle.properties < EOF
systemProp.http.proxyHost=$PROXY_HOST
systemProp.http.proxyPort=$PROXY_PORT
systemProp.https.proxyHost=$PROXY_HOST
systemProp.https.proxyPort=$PROXY_PORT
EOF
fi