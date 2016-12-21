#!/bin/bash

echo "debconf debconf/frontend select noninteractive" | sudo debconf-set-selections
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:securityonion/stable
sudo apt-get update

#sudo apt-get -y install securityonion-client
#sudo apt-get -y install securityonion-sensor
#sudo apt-get -y install securityonion-elsa securityonion-elsa-extras syslog-ng-core
#sudo apt-get -y install securityonion-all syslog-ng-core
#sudo apt-get -y install securityonion-iso syslog-ng-core
