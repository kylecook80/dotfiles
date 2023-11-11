#!/usr/bin/env bash

IPTABLES=/sbin/iptables
INET_LOCAL=

$IPTABLES -F
$IPTABLES -X
$IPTABLES -t nat -F
$IPTABLES -t nat -X
$IPTABLES -t mangle -F
$IPTABLES -t mangle -X
$IPTABLES -t raw -F
$IPTABLES -t raw -X
$IPTABLES -t security -F
$IPTABLES -t security -X
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP

$IPTABLES -A INPUT -i lo -j ACCEPT -m comment --comment "Free reign for loopback"
$IPTABLES -A INPUT -p icmp -j ACCEPT -m comment --comment "Allow ICMP"
$IPTABLES -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Allow established/related connections"
$IPTABLES -A INPUT -m conntrack --ctstate INVALID -j DROP -m comment --comment "Drop invalid packets"

$IPTABLES -N services
$IPTABLES -A services -p tcp -m tcp --dport 22 -j ACCEPT -m comment --comment "SSH"
$IPTABLES -A INPUT -j services -m comment --comment "Open service ports"

$IPTABLES -N icmp
$IPTABLES -A icmp -p icmp -m limit --limit 1/s --limit-burst 4 -j ACCEPT -m comment --comment "Rate limit ICMP"
$IPTABLES -A icmp -p icmp --icmp-type echo-request -j ACCEPT -m comment --comment "Allow echo request packets"
$IPTABLES -A icmp -p icmp --icmp-type fragmentation-needed -j ACCEPT -m comment --comment "Allow fragmentation needed packets"
$IPTABLES -A icmp -p icmp --icmp-type time-exceeded -j ACCEPT -m comment --comment "Allow time exceeded packets"
$IPTABLES -A icmp -p icmp -s $INET_LOCAL -j ACCEPT -m comment --comment "Allow all icmp from local subnet"
$IPTABLES -A icmp -p icmp -j DROP -m comment --comment "Drop all other icmp packets"
$IPTABLES -A INPUT -j icmp -m comment --comment "ICMP rules"

$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset -m comment --comment "Reject unknown TCP packets with TCP RST"
$IPTABLES -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable -m comment --comment "Reject unknown UDP packets with ICMP port unreachable"
$IPTABLES -A INPUT -j REJECT --reject-with icmp-proto-unreachable -m comment --comment "Reject all other packets with ICMP protocol unreachable"

$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT ACCEPT
