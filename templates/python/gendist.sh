#!/usr/bin/env bash

# Enable tracing
# set -x

# Enable Debug Mode
# DEBUG="T"

# Set extended globbing
# shopt -s extglob

# Set recursive globbing
# shopt -s globstar

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"

__version="0.0.1"

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`

printdebug()
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

OPTS=`getopt -o h --long help -n "${__file}" -- "$@"`
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
            break
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

FILES=""

if ! hash "zip" 2> /dev/null; then
    "This script requires the zip utility. Exiting."
fi

if [[ -d "dist/" ]]; then
    rm -rf "dist/"
fi

mkdir -p dist/

for i in $FILES; do
    cp -r $i dist/$i
done

if hash "zip" 2> /dev/null; then
    name="edrtool-${__version}"

    if [[ -f "${name}.zip" ]]; then
        rm "${name}.zip"
    fi

    cp -r dist ${name}
    zip -r "${name}.zip" "${name}"
    rm -rf ${name}
fi

# vim: ai et nu ts=4 sw=4 sts=4 ft=sh :
