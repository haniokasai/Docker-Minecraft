#!/bin/sh
WDIR=/minecraft/resources
mkdir $WDIR/bds
unzip $WDIR/bds.zip $WDIR/resources/bds
mv $WDIR/resources/bds/bedrock_server /minecraft/bin/bedrock_server
mv $WDIR/resources/bds/* /minecraft/server/
TODO config