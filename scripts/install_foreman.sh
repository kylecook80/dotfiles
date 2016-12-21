#!/bin/bash

apt-get -y install ca-certificates
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
dpkg -i puppetlabs-release-pc1-jessie.deb

echo "deb http://deb.theforeman.org/ jessie 1.13" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.13" >> /etc/apt/sources.list.d/foreman.list
apt-get -y install ca-certificates
wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

apt-get update && apt-get -y install foreman-installer
foreman-installer
