#!/bin/sh
echo "Starting sftpd..." >&1
sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/config-FTP.sh
exec /usr/sbin/sshd -D -e &
echo $! > /minecraft/bin/sftpd.pid
cat /minecraft/bin/sftpd.pid
echo "Starting sftpd...done" >&1