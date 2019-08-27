#!/bin/sh
echo "run cuberite...." >&1

sh /minecraft/resources/setPerm.sh

/minecraft/bin/cuberite_binfile
echo "run cuberite....done" >&1

