#!/bin/bash

find /etc/apt/preferences.d/ -type f -print0 | xargs -r -0 basename -s .pref | xargs -r apt-get -y install
