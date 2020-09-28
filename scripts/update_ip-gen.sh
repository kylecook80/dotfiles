#!/usr/bin/env bash

. shinc/stdlib.shinc

# Include private variables containing API key
if [[ ! -f "$HOME/.private" ]]; then
    error "Cannot find $HOME/.private. Exiting."
    exit 1
fi

. $HOME/.private

function querydns()
{
    msg "Fetching DNS Records"
    curl -s -X GET \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${DO_TOKEN}" \
        "https://api.digitalocean.com/v2/domains/${DO_DOMAIN}/records" | jq .
}

function getip()
{
    IP=$(/usr/bin/curl -ks https://wtfismyip.com/text)
}

function updatedns()
{
    for i in "${DO_RECORD_ID[@]}"
    do
        task "Update Record $i"
        reply=$(curl -s -X PUT -H "Content-Type: application/json" \
            -H "Authorization: Bearer ${DO_TOKEN}" \
            -d "{\"data\":\"$IP\"}" \
            "https://api.digitalocean.com/v2/domains/${DO_DOMAIN}/records/$i")
        check=$(echo $reply | jq ".domain_record.id == $i and .domain_record.data == \"$IP\"")
        if [ "$check" = "true" ]
        then
            echo "Complete"
        else
            echo "Error"
        fi
    done
}

function usage()
{
    echo "Usage: $0 [-q] [-u]"
}

if [[ -z $DO_TOKEN ]]; then
    error "No token set."
    exit 1
fi

if [[ -z $DO_DOMAIN ]]; then
    error "No domain set."
    exit 1
fi

if [[ -z $DO_RECORD_ID ]]; then
    error "No record IDs."
    exit 1
fi

getip

if [ $# = 0 ]
then
    updatedns
    exit 0
fi

while [ "$1" != "" ]
do
    case $1 in
        -h | --help )
            usage
            exit
            ;;
        -q | --query )
            shift
            querydns
            ;;
        -u | --update )
            shift
            updatedns
            ;;
    esac
done
