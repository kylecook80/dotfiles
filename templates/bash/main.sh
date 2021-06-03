#!/bin/bash

# Enable tracing
#set -x

# Enable Debug Mode
#DEBUG="T"

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"

__version="0.0.1"

source "${dir}/lib/stdlib.shinc"

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

### Put variables and options here

### Put functions here

while [[ -n $1 ]]; do
    case "$1" in
        -h|--help)
            help
            exit
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

# Main execution starts here
