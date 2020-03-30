#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources


rm -rf /minecraft/bin/bds/*

rm -rf /minecraft/bin/bedrock_server
rm -rf /minecraft/bin/libCrypto.so
rm -rf /usr/local/lib/libCrypto.so

rsync ${WDIR}/bdssync/ /minecraft/server/ -aq --delete --exclude worlds --exclude server.properties --exclude ops.json --exclude whitelist.json --exclude permissions.json --exclude backup --exclude bedrock_server --exclude libCrypto.so

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockTCP.sh

cd /minecraft/server

if [ ! -e "/minecraft/server/permissions.json"  ]; then
	echo "touching permissions.json..." >&1
	echo "[]" > permissions.json
fi

if [ ! -e "/minecraft/server/whitelist.json"  ]; then
	echo "touching whitelist.json..." >&1
	echo "[]" > permissions.json
fi

LD_LIBRARY_PATH=${WDIR}/bdssync ${WDIR}/bdssync/bedrock_server

echo "run bds....done" >&1
