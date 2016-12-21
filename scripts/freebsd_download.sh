#!/bin/bash

URL="ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/11.0-RELEASE"
PACKAGES="base doc kernel lib32 ports src"

for pkg in $PACKAGES; do
    wget $URL/$pkg.txz
done

