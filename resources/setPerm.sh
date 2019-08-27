#!/bin/sh
echo "chmod...." >&1

chgrp ftpgroup /minecraft/server -R
chmod 2111 /minecraft/resources -R
chmod 2111 /minecraft/bin -R
chmod 2777 /minecraft/server -R

echo "chmod....done" >&1
