#!/usr/bin/env bash

TEMPDIR="$HOME/.templates"

if [[ "$1" == "" ]]; then
    ls $TEMPDIR
    exit 0
fi

case $1 in
    -p )
        shift
        projecttype=$1
        projectname=$2
        ;;
    * )
        filename=$1
esac

if [[ "$projecttype" != "" ]]; then
    case $projecttype in
        c )
            if [[ "$projectname" != "" ]]; then
                cp -r "$TEMPDIR/cproj/" "./$projectname"
            fi
            ;;
        * )
            echo "Unknown project type $projecttype"
    esac
else
    if [[ ! -a "$HOME/templates/$filename" ]]; then
        echo "File $filename is not a template file."
        exit 1
    fi
    cp "$HOME/templates/$filename" .
fi
