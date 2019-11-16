#!/bin/sh
echo "pre process...." >&1
WDIR=/minecraft/resources
cd ${WDIR}

if [ "${SRVTYPE}" =  "mcpc" ]; then
	echo "Copy mcpc_vanilla_*.jar..." >&1
	cp mcpc_vanilla_*.jar /minecraft/bin/mcpc.jar
elif [ "${SRVTYPE}" =  "spigot" ]; then
	echo "Copy mcpc_spigot_*.jar..." >&1
	cp mcpc_spigot_*.jar /minecraft/bin/mcpc.jar
elif [ "${SRVTYPE}" =  "bukkit" ]; then
	echo "Copy mcpc_craftbukkit_*.jar..." >&1
	cp mcpc_craftbukkit_*.jar /minecraft/bin/mcpc.jar
else
	echo "Copy mcpc_vanilla_*.jar..." >&1
	cp mcpc_vanilla_*.jar /minecraft/bin/mcpc.jar
fi
PROP=/minecraft/server/server.properties
cp server.properties.vanilla ${PROP}

#config
echo "motd=${SRVID} [MiRm-MCPC]" >> ${PROP}

echo "pre process....done" >&1