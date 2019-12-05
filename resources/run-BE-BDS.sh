#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources


if [ -e ${WDIR}/bds.zip ]; then
	echo "${WDIR}/bds.zip is exist"  >&1
	mkdir -p /minecraft/bin/bds/
	rm -rf /minecraft/bin/bds/*
	mkdir -p  /minecraft/bin/bds/
	cd /minecraft/bin/bds/
	cp ${WDIR}/bds.zip /minecraft/bin/bds/bds.zip
	unzip -qq bds.zip
	rm -rf bds.zip
	rm -rf /minecraft/bin/bedrock_server
	rm -rf /minecraft/bin/libCrypto.so
	mv /minecraft/bin/bds/bedrock_server /minecraft/bin/bedrock_server
	mv /minecraft/bin/bds/libCrypto.so /usr/local/lib/libCrypto.so
	chmod 755 /usr/local/lib/libCrypto.so
	rsync /minecraft/bin/bds/ /minecraft/server/ -aq --delete --exclude worlds --exclude server.properties --exclude ops.json --exclude whitelist.json --exclude permissions.json --exclude backup

else
	echo "${WDIR}/bds.zip is NOT exist"  >&1
fi

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockTCP.sh

cd /minecraft/server
export LD_LIBRARY_PATH=/usr/local/lib
su ${SRVID} -p -c "cd /minecraft/server ;  /minecraft/bin/bedrock_server"
echo "run bds....done" >&1
