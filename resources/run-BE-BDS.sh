#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources


rm -rf /minecraft/bin/bds/*

rm -rf /minecraft/bin/bedrock_server
rm -rf /minecraft/bin/libCrypto.so
rm -rf /usr/local/lib/libCrypto.so

rsync ${WDIR}/bdssync/ /minecraft/server/ -aq --delete --exclude "worlds/" --exclude server.properties --exclude ops.json --exclude whitelist.json --exclude permissions.json --exclude "backup/" --exclude bedrock_server --exclude libCrypto.so

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockTCP.sh

cd /minecraft/server

if [ ! -e "/minecraft/server/permissions.json"  ]; then
	echo "touching permissions.json..." >&1
	echo "[]" > permissions.json
fi

if [ ! -e "/minecraft/server/whitelist.json"  ]; then
	echo "touching whitelist.json..." >&1
	echo "[]" > whitelist.json
fi

if [ ! -e "/minecraft/server/ops.json"  ]; then
	echo "touching  ops.json..." >&1
	echo "[]" >  ops.json
fi

if [ ! -e "/minecraft/server/server.properties"  ]; then
	echo "making sever.properties..." >&1
	sh /minecraft/resources/make_Properties_BDS.sh
fi

if [ -e "/minecraft/server/worlds/level"  ]; then
	echo "replacing world name in properties world to level..." >&1
	sed -i -e "s/level-name=world/level-name=level/g" /minecraft/server/server.properties
fi

if [ -e "/minecraft/server/enablewhitelist"  ]; then
		sed -i -e "s/white-list=false/white-list=true/g" /minecraft/server/server.properties
		echo "whitelistをオンにします..." >&1
else
		sed -i -e "s/white-list=true/white-list=false/g" /minecraft/server/server.properties
		echo "whitelistをオフにします..." >&1
fi

LD_LIBRARY_PATH=${WDIR}/bdssync ${WDIR}/bdssync/bedrock_server

echo "run bds....done" >&1
