#!/usr/bin/env bash

# Exit on error
# set -e

# Enable tracing
# set -x

# Enable Debug Mode
# DEBUG="T"

# Set extended globbing
# shopt -s extglob

# Set recursive globbing
# shopt -s globstar

__version="0.0.1"

OS=$(uname | tr '[:upper:]' '[:lower:]')

[ -s "./lib/stdlib.shinc" ] && source "./lib/stdlib.sh"

printvars()
{
    debug "__dir = ${__dir}"
    debug "__file = ${__file}"
    debug "__base = ${__base}"
    debug "__root = ${__root}"
    debug ""
    debug "__version = ${__version}"
}

help()
{
    echo -e "${__base} - Description"
    echo -e ""
    echo -e "Usage:"
    echo -e "\t${__base} [options]"
    echo -e ""
    echo -e "Options:"
    echo -e "\t-h | --help\t\tShow this screen"
    echo -e ""
}

OPTS=$(getopt -o h --long help -n "${__file}" -- "$@")
if [ $? != 0 ]; then
    echo "Exiting..." >&2
    exit 1
fi
eval set -- "$OPTS"

while true; do
    case "$1" in
        -h|--help)
            help
            exit
        ;;
        --)
            shift
        ;;
        *)
            echo "Unknown option: $1"
            echo ""
            help >&2
            exit 1
        ;;
    esac
    shift
done

# vim: ai et nu ts=4 sw=4 sts=4 ft=sh :
