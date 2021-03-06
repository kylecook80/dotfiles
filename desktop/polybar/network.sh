#!/usr/bin/env sh

INTERFACE=$(ifconfig -l -u | cut -d' ' -f1)
echo "$INTERFACE: online"
