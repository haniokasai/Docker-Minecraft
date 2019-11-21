#!/bin/sh
echo "chmod...." >&1

chgrp ftpgroup /minecraft/server -R
chown root:root /minecraft/server
chmod 2755 /minecraft/server 
chmod 2777 /minecraft/server/* -R
chmod 2111 /minecraft/bin -R

echo "chmod....done" >&1
