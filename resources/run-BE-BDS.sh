#!/bin/sh
echo "run bds...." >&1

WDIR=/minecraft/resources
mkdir -p ${WDIR}/bds
rm -rf ${WDIR}/bds/*
cd ${WDIR}
mv ${WDIR}/bds.zip ${WDIR}/bds/bds.zip
cd ${WDIR}/bds/
unzip bds.zip
rm -rf bds.zip
rm -rf /minecraft/bin/bedrock_server
mv ${WDIR}/bds/bedrock_server /minecraft/bin/bedrock_server
rsync ${WDIR}/bds/ /minecraft/server/ -av --delete --exclude worlds --exclude server.properties --exclude ops.json --exclude whitelist.json --exclude permissions.json

sh /minecraft/resources/setPerm.sh
cd /minecraft/bin
LD_LIBRARY_PATH=. ./bedrock_server

echo "run bds....done" >&1
