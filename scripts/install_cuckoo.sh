#!/bin/bash

INSTALL_DIR=/opt/cuckoo
if [[ -d /opt/cuckoo && $1 != "-f" ]]; then
    echo "/opt/cuckoo already exists. Exiting..."
    exit 1
fi

TEMP=$(mktemp -d)
cd $TEMP

OS=$(uname | tr 'A-Z' 'a-z')
if [[ $OS = 'linux' ]]; then
    echo "Installing cuckoo dependencies"
    apt-get update
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    apt-get install -y curl tcpdump mongodb python-dev libffi-dev libssl-dev libxml2-dev \
        libxslt1-dev python-imaging libcurl4-openssl-dev libjpeg-dev
else
    echo "Operating System not supported."
    exit 1
fi

echo "Installing Cuckoo"
git clone https://github.com/cuckoosandbox/cuckoo.git $INSTALL_DIR
cd $INSTALL_DIR
pip install -r requirements.txt
pip install virtualenv
virtualenv .
. bin/activate
./utils/community.py -wafb monitor
setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump # Allow tcpdump to be used by non-root users
pip install markerlib
pip install androguard
deactivate

if [[ $OS = 'linux' ]]; then
    echo "Installing libvirt dependencies"
    apt-get install -y libtool autoconf autopoint pkg-config xsltproc libxml-xpath-perl \
        libxml2-utils libdevmapper-dev libnl-3-dev libnl-route-3-dev gettext
else
    echo "Operating System not supported."
    exit 1
fi

echo "Installing libvirt"
cd $TEMP
git clone git://libvirt.org/libvirt.git
cd libvirt
./autogen.sh
./configure --prefix=/usr --with-esx
make
make install

if [[ $OS = 'linux' ]]; then
    echo "Installing yara dependencies"
    apt-get install -y bison
else
    echo "Operating System not supported."
fi

echo "Installing yara"
cd $TEMP
git clone https://github.com/VirusTotal/yara.git
cd yara
git checkout v3.4.0 -b v3.4.0
./bootstrap.sh
./configure --prefix=/usr
make
make install

echo "Installing yara-python"
cd $TEMP
git clone https://github.com/VirusTotal/yara-python.git
cd yara-python
git checkout v3.4.0 -b v3.4.0
python setup.py build
python setup.py build install

echo "Installation Complete. Please configure Cuckoo."
