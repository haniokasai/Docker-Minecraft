#!/bin/sh
echo "block tcp...." >&1
#iptables -A OUTPUT -p tcp -j DROP
iptables -t filter -I OUTPUT 1 -m state --state NEW -j DROP -p tcp
echo "block tcp....done" >&1
