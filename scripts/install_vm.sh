#!/bin/bash

sudo virt-install \
    --connect qemu:///system \
    --virt-type kvm \
    --name test \
    --memory 512 \
    --disk size=5 \
    --cdrom /home/kyle/debian-8.5.0-amd64-netinst.iso \
    --boot hd,cdrom \
    --network network=default \
    --graphics vnc,listen=0.0.0.0
