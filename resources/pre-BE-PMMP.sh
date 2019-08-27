#!/bin/sh
tar zxvf /minecraft/resources/PHP-7.3-Linux-x86_64.tar.gz /minecraft/bin
mkdir -p /minecraft/server/plugins
CONFIGFILE = /minecraft/server/server.properties
#config

#env
if [[ -z "${WORLDTYPE}" ]]; then
    WORLDTYPE = "flat"
fi
if [[! "${WORLDTYPE}" -eq "flat"]]; then
     WORLDTYPE -eq  "default"
fi
if [[ -z "${GAMEMODE}" ]]; then
    GAMEMODE = "creative"
fi
if [[ ${GAMEMODE} = "creative" ]];then
    GAMEMODE = 1
else
    GAMEMODE = 0
fi
if [[ -z "${SRVDOMAIN}" ]]; then
	SRVDOMAIN = "0.0.0.0"
fi

echo "motd=${SRVID} [MiRmPE]" > CONFIGFILE
echo "server-port=19132" > CONFIGFILE
echo "level-type=${WORLDTYPE}" > CONFIGFILE
echo "gamemode=${GAMEMODE}" > CONFIGFILE
echo "server-ip=${SRVDOMAIN}" > CONFIGFILE
echo "language=jpn" > CONFIGFILE
