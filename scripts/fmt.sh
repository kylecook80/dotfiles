#!/usr/bin/env bash

while getopts "hw:" opt; do
    case $opt in
        h) hyph=1;;
        w) width="$OPTARG";;
    esac
done

shift $(($OPTIND - 1))

nroff << EOF
.ll ${width:-72}
.na
.hy ${hyph:-O}
.pl 1
$(cat "$@")
EOF

exit 0

