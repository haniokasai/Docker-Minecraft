#!/bin/sh
echo "run cuberite...." >&1

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockUDP.sh

/minecraft/bin/cuberite_binfile
echo "run cuberite....done" >&1

