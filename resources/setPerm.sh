#!/bin/sh
echo "chmod...." >&1

#For sshd  bad ownership or modes for chroot directory "/minecraft/server"
chown root  /minecraft/
chmod 2755  /minecraft/
##

chgrp ftpgroup /minecraft/server -R
chown ${SRVID}:ftpgroup /minecraft/server/ -R

chmod 2777 /minecraft/server/ -R

chmod 2755 /minecraft/bin -R
chmod 2755 /minecraft/restore -R
chmod 2755 /minecraft/defaultplugins -R

echo "chmod....done" >&1
