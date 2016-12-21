#!/bin/bash

virt-install \
    --connect qemu:///system \
    --virt-type kvm \
    --name test \
    --memory 512 \
    --disk size=5 \
    --cdrom /home/kyle/debian-8.5.0-amd64-netinst.iso \
    --boot cdrom,hd \
    --network network=internal \
    --paravirt
