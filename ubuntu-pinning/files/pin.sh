#!/bin/bash

find /etc/apt/preferences.d/ -type f | xargs -r rm

apt list --installed | grep -v "Listing" | while read LINE; do
    PKG=$(echo $LINE | cut -d' ' -f1 | cut -d'/' -f 1)
    VER=$(echo $LINE | cut -d' ' -f2)
    (
        echo Package: $PKG
        echo Pin: version $VER
        echo Pin-Priority: 1000
    ) > /etc/apt/preferences.d/$PKG.pref
done