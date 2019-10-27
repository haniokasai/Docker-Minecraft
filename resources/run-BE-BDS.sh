#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources
mkdir -p ${WDIR}/bds


if [ -e ${WDIR}/bds.zip ]; then
	echo "${WDIR}/bds.zip is exist"  >&1
	if [ ! -z "${MD5HASH}" ]; then
		MD5HASH="ex"
	fi
	NEWHASH=`md5sum ${WDIR}/bds.zip`
	if [ "${MD5HASH}" != "${NEWHASH}" ]; then
		echo "HASH is DIFFERENT"  >&1
		HA=`md5sum bds.zip`
		export MD5HASH=${HA}
		rm -rf ${WDIR}/bds/*
		cd ${WDIR}
		mv ${WDIR}/bds.zip ${WDIR}/bds/bds.zip
		cd ${WDIR}/bds/
		unzip -qq bds.zip
		rm -rf bds.zip
		rm -rf /minecraft/bin/bedrock_server
		rm -rf /minecraft/bin/bedrock_server
		rm -rf /minecraft/bin/libCrypto.so
		mv ${WDIR}/bds/bedrock_server /minecraft/bin/bedrock_server
		mv ${WDIR}/bds/libCrypto.so /usr/local/lib/libCrypto.so
		rsync ${WDIR}/bds/ /minecraft/server/ -aq --delete --exclude worlds --exclude server.properties --exclude ops.json --exclude whitelist.json --exclude permissions.json --exclude backup
	else
		echo "HASH is SAME"  >&1
	fi
else
	echo "${WDIR}/bds.zip is NOT exist"  >&1
fi


sh /minecraft/resources/setPerm.sh
cd /minecraft/server
LD_LIBRARY_PATH=/usr/local/lib /minecraft/bin/bedrock_server

echo "run bds....done" >&1
