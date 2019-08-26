#!/bin/sh
WDIR=/minecraft/resources
mkdir $WDIR/bds
unzip $WDIR/bds.zip $WDIR/resources/bds
mv $WDIR/resources/bds/bedrock_server /minecraft/bin/bedrock_server
mv $WDIR/resources/bds/* /minecraft/server/
#config
rm /minecraft/server/server.properties
mv $WDIR/resources/server.properties.bds /minecraft/server/server.properties

sed -i -e "s/=v=srvid=v=/${SRVID}/g" server.properties
sed -i -e "s/=v=difficulty=v=/${DIFFICULTY}/g" server.properties
sed -i -e "s/=v=gamemode=v=/${GAMEMODE}/g" server.properties
sed -i -e "s/=v=permission=v=/${PERMISSION}/g" server.properties