#!/bin/sh

if [ ! -z "$PROXY" ]
then
        export HTTP_PROXY=$PROXY
        export HTTPS_PROXY=$PROXY
        export http_proxy=$PROXY
        export https_proxy=$PROXY
fi