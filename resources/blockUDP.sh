#!/bin/sh
echo "block udp...." >&1
iptables -A OUTPUT -p udp -j DROP
iptables -t filter -I OUTPUT 1 -m state --state NEW -j DROP -p udp
echo "block udp....done" >&1
