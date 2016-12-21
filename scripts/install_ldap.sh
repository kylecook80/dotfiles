// Server
sudo apt-get install slapd ldap-utils libpam-ldap
sudo dpkg-reconfigure slapd
sudo dpkg-reconfigure libpam-ldap

sudo apt-get install phpldapadmin
// configure /etc/phpldapadmin/config.php

// Clients
sudo apt-get libpam-ldap nscd nslcd

// configure /etc/nsswitch.conf

// configure /etc/pam.d/common-session
// session required pam_mkhomedir.so skel=/etc/skel umask=0022
