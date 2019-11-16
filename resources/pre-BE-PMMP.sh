#!/bin/sh
echo "pre process...." >&1

cp /minecraft/resources/PHP*.tar.gz /minecraft/bin/PHP.tar.gz
cd /minecraft/bin/
tar zxvf /minecraft/bin/PHP.tar.gz
mkdir -p /minecraft/server/plugins
CONFIGFILE=/minecraft/server/server.properties
#これ不要、代わりにupdate時は直接/minecraft/server/pmmp.pharにおく
#mv /minecraft/resources/pmmp_*.phar /minecraft/server/pmmp.phar
cp /minecraft/bin/bin/php7/lib/* /usr/lib/
#env
if [ -z "${WORLDTYPE}" ]; then
	WORLDTYPE="flat"
fi
if [ ! "${WORLDTYPE}" = "flat" ]; then
	 WORLDTYPE =  "default"
fi
if [ -z "${GAMEMODE}" ]; then
	GAMEMODE="creative"
fi
if [ ${GAMEMODE} = "creative" ];then
	GAMEMODE=1
else
	GAMEMODE=0
fi
if [ -z "${SRVDOMAIN}" ]; then
	SRVDOMAIN="0.0.0.0"
fi

#config
echo "motd=${SRVID} [MiRm-PMMP]" > ${CONFIGFILE}
echo "server-port=19132" >> ${CONFIGFILE}
echo "level-type=${WORLDTYPE}" >> ${CONFIGFILE}
echo "gamemode=${GAMEMODE}" >> ${CONFIGFILE}
echo "server-ip=${SRVDOMAIN}" >> ${CONFIGFILE}
echo "language=jpn" >> ${CONFIGFILE}
echo "xbox-auth=false" >> ${CONFIGFILE}
#plugin
sh /minecraft/resources/pluginSync.sh
echo "pre process....done" >&1
