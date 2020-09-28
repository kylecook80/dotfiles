#!/usr/bin/env bash

. shinc/stdlib.shinc

# Include private variables
if [[ ! -f "$HOME/.private" ]]; then
    error "Cannot find $HOME/.private. Exiting."
    exit 1
fi

. $HOME/.private

certbot certonly \
    --dns-digitalocean \
    --dns-digitalocean-credentials /etc/digitalocean.conf \
    --server https://acme-v02.api.letsencrypt.org/directory \
    -d ${DOMAIN} \
    -d *.${DOMAIN}
