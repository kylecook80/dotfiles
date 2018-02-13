#!/usr/bin/env sh

mixer vol | awk '{print $7;};' | cut -d : -f 1
