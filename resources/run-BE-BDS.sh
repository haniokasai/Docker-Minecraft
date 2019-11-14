#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources
mkdir -p ${WDIR}/bds


if [ -e ${WDIR}/bds.zip ]; then
	echo "${WDIR}/bds.zip is exist"  >&1
	if [  ! -e "/minecraft/bin/BDShash" ]; then
		touch /minecraft/bin/BDShash
	fi
	NEWHASH=`md5sum ${WDIR}/bds.zip`
	declare file_content=$( cat /minecraft/bin/BDShash )

	if [ "${file_content}" =~ "${NEWHASH}" ]; then
		echo "HASH is SAME"  >&1
	else
		echo "HASH is DIFFERENT"  >&1
		md5sum ${WDIR}/bds.zip > /minecraft/bin/BDShash
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
	fi
else
	echo "${WDIR}/bds.zip is NOT exist"  >&1
fi


sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockTCP.sh

cd /minecraft/server
su -l ${SRVID} -c "cd /minecraft/server ; LD_LIBRARY_PATH=/usr/local/lib /minecraft/bin/bedrock_server"
echo "run bds....done" >&1
