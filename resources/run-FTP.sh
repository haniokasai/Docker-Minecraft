#!/bin/sh
echo "Starting sftpd..." >&1
rm -rf /minecraft/ftpworkdir
sh /minecraft/resources/setPerm.sh
mkdir -p /minecraft/ftpworkdir/server
usermod -d /minecraft/ftpworkdir ${SRVID}
mount --bind /minecraft/server /minecraft/ftpworkdir/server
exec /usr/sbin/sshd -D -e &
echo $! > /minecraft/bin/sftpd.pid
cat /minecraft/bin/sftpd.pid
echo "Starting sftpd...done" >&1