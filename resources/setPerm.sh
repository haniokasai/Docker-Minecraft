#!/bin/sh
echo "chmod...." >&1

chgrp ftpgroup /minecraft/server -R
chown ${SRVID} /minecraft/server/ -R
chmod 2777 /minecraft/server/ -R

#For sshd  bad ownership or modes for chroot directory "/minecraft/server"
chown root /minecraft/ftpworkdir
chmod 2755 /minecraft/ftpworkdir
##

chmod 2111 /minecraft/bin -R

echo "chmod....done" >&1
