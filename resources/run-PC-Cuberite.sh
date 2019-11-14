#!/bin/sh
echo "run cuberite...." >&1

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockUDP.sh

su -l ${SRVID} -c "cd /minecraft/server & /minecraft/bin/cuberite_binfile"
echo "run cuberite....done" >&1

