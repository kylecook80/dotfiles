#!/bin/bash

echo $1 | tee /etc/hostname | xargs hostname
