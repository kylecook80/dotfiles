#!/usr/bin/env bash

# Include private variables
. $HOME/.private

certbot certonly \
    --dns-digitalocean \
    --dns-digitalocean-credentials /etc/digitalocean.conf \
    --server https://acme-v02.api.letsencrypt.org/directory \
    -d ${DOMAIN} \
    -d *.${DOMAIN}
