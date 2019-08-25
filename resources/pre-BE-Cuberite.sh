#!/bin/sh
WDIR=/minecraft/resources
tar zxvf $WDIR/cuberite20190826.tgz
mv $WDIR/resources/cuberite_binfile /minecraft/bin/cuberite_binfile
mv $WDIR/resources/cuberite_src/* /minecraft/server/
TODO config