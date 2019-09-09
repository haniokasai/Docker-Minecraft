#!/bin/sh
echo "pre process...." >&1
WDIR=/minecraft/resources
cd ${WDIR}
sh blockUDP.sh

mv mcpc_vanilla_*.jar /minecraft/bin/mcpc.jar
PROP=/minecraft/server/server.properties
cp server.properties.vanilla ${PROP}

#config
echo "motd=${SRVID} [MiRm-Vanilla]" >> ${PROP}

echo "pre process....done" >&1