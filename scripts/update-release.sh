#!/usr/bin/env bash

RELEASE=$1
PREFIX=$2

if [[ -z $RELEASE ]]; then
	echo "Please pass a RELEASE."
	exit 1
fi

if [[ -z $PREFIX ]]; then
	echo "Please pass a PREFIX."
	exit 1
fi

mkdir -p ${PREFIX}/dists/$RELEASE/main/binary-amd64
mkdir -p ${PREFIX}/dists/$RELEASE/main/binary-i386
mkdir -p ${PREFIX}/dists/$RELEASE/main/binary-arm64
mkdir -p ${PREFIX}/dists/$RELEASE/main/binary-armhf

mkdir -p ${PREFIX}/pool/main

pushd ${PREFIX}/

dpkg-scanpackages -a amd64 -m . > dists/$RELEASE/main/binary-amd64/Packages
dpkg-scanpackages -a i386 -m . > dists/$RELEASE/main/binary-i386/Packages
dpkg-scanpackages -a arm64 -m . > dists/$RELEASE/main/binary-arm64/Packages
dpkg-scanpackages -a armhf -m . > dists/$RELEASE/main/binary-armhf/Packages

cat dists/$RELEASE/main/binary-amd64/Packages | gzip -9 > dists/$RELEASE/main/binary-amd64/Packages.gz
cat dists/$RELEASE/main/binary-i386/Packages | gzip -9 > dists/$RELEASE/main/binary-i386/Packages.gz
cat dists/$RELEASE/main/binary-arm64/Packages | gzip -9 > dists/$RELEASE/main/binary-arm64/Packages.gz
cat dists/$RELEASE/main/binary-armhf/Packages | gzip -9 > dists/$RELEASE/main/binary-armhf/Packages.gz

pushd dists/$RELEASE
rm Release InRelease Release.gpg

cat << EOF > Release
Origin: My Repo
Label: Repo
Suite: stable
Codename: $RELEASE
Version: 1.0
Architectures: amd64 i386 arm64 armhf
Components: main
EOF

apt-ftparchive release . >> Release

popd

cat dists/$RELEASE/Release | gpg --default-key kylecook80@gmail.com -abs > dists/$RELEASE/Release.gpg
cat dists/$RELEASE/Release | gpg --default-key kylecook80@gmail.com -abs --clearsign > dists/$RELEASE/InRelease

popd # ${PREFIX}/

