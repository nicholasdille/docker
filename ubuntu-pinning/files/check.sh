#!/bin/bash

rm -f installed-*
apt list --installed | grep -v "Listing" | while read LINE; do PKG=$(echo $LINE | cut -d' ' -f1| cut -d'/' -f 1); VER=$(echo $LINE | cut -d' ' -f2); echo $PKG >> installed-pkg.txt; echo $PKG $VER >> installed-pkg-ver.txt; done

rm -f pinned-*
find /etc/apt/preferences.d/ -type f | while read FILE; do PKG=$(basename -s .pref $FILE); VER=$(cat $FILE | grep "Pin:" | cut -d' ' -f3); echo $PKG >> pinned-pkg.txt; echo $PKG $VER >> pinned-pkg-ver.txt; done
cat pinned-pkg.txt | sort > pinned-pkg.txt
cat pinned-pkg-ver.txt | sort > pinned-pkg-ver.txt

diff -u pinned-pkg.txt installed-pkg.txt > pkg.txt
diff -u pinned-pkg-ver.txt installed-pkg-ver.txt > pkg-ver.txt
