#!/bin/sh
echo "chmod...." >&1

#For sshd  bad ownership or modes for chroot directory "/minecraft/server"
chown root  /minecraft/
chmod 755  /minecraft/
##

chgrp ftpgroup /minecraft/server -R
chown ${SRVID}:ftpgroup /minecraft/server/ -R

chmod 777 /minecraft/server/ -R

chmod 711 /minecraft/bin -R
chown root:root /minecraft/bin -R
chmod 755 /minecraft/restore -R
chown root /minecraft/restore -R
chmod 755 /minecraft/defaultplugins -R
chown root /minecraft/defaultplugins -R

echo "chmod....done" >&1
