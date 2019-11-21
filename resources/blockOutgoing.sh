#!/bin/sh
#sshは抜こう
iptables -A OUTPUT -p tcp --dport 1:1023 -j REJECT --reject-with tcp-reset
iptables -A OUTPUT -p udp --dport 1:1023 -j DROP
iptables -A OUTPUT -p tcp --dport 1:1023 -j DROP
iptables -A OUTPUT -p icmp -j DROP

#http://www2s.biglobe.ne.jp/~nuts/labo/inti/ipt_recent.html
#172.17.0.1  is docker network inspect bridges's
#iptables -A INPUT -p tcp --syn ! -s 172.17.0.1  --dport 22 -m recent --name sshattack --set
#iptables -A INPUT -p tcp --syn ! -s 172.17.0.1 --dport 22 -m recent --name sshattack --rcheck --seconds 60 --hitcount 5 -j LOG --log-prefix 'SSH attack: '
#iptables -A INPUT -p tcp --syn ! -s 172.17.0.1 --dport 22 -m recent --name sshattack --rcheck --seconds 60 --hitcount 5 -j DROP
