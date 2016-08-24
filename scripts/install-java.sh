#!/bin/bash

OS=`uname | tr "[A-Z]" "[a-z]" | sed s/darwin/macosx/`

if [[ $EUID != 0 ]]; then
    echo "Please use sudo with this script."
    exit 1
fi

PROD=jdk
VERS=8u102
ARCH=x64

IFS="u"
VERS_ARRAY=(${VERS[@]})
IFS=" "

MAJOR=${VERS_ARRAY[0]}
MINOR=${VERS_ARRAY[1]}
EXPANDED="$MAJOR Update $MINOR"
FOLDERNAME=${PROD}1.${MAJOR}.0_${MINOR}
FILENAME=$PROD-$VERS-$OS-$ARCH

case $OS in
"macosx")
    cd /tmp &> /dev/null
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/$PROD/$VERS-b14/$FILE.dmg &> /dev/null
    hdiutil attach $FILENAME.dmg &> /dev/null
    cd "/Volumes/$PROD $EXPANDED" &> /dev/null
    installer -pkg "$PROD $EXPANDED.pkg" -target / &> /dev/null
    ;;
"linux")
    if [[ -d /opt/java/$FOLDERNAME && $1 != "-f" ]]; then
        echo "JDK already installed. Use -f to force."
        exit 1
    fi

    if [[ $1 = "-f" ]]; then
        rm -rf /opt/java/$FOLDERNAME &> /dev/null
    fi

    echo "Creating directories..."
    mkdir -p /opt/java &> /dev/null
    cd /tmp &> /dev/null

    echo "Downloading java..."
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/$PROD/$VERS-b14/$FILENAME.tar.gz &> /dev/null

    echo "Installing java..."
    tar xfvz $FILENAME.tar.gz &> /dev/null
    rm $FILENAME.tar.gz &> /dev/null
    mv $FOLDERNAME /opt/java/ &> /dev/null

    echo "Complete"
    # printf "Add to .bashrc/*rc file:\n\texport JAVA_HOME=/opt/java/$FILENAME\n\texport PATH=$JAVA_HOME/bin:$PATH"
    ;;
*)
    echo "Unsupported Operating System."
    exit 1
    ;;
esac
