#!/bin/sh
echo "make properties  process...." >&1

WDIR=/minecraft/resources

#config
rm /minecraft/server/server.properties
cp ${WDIR}/server.properties.bds /minecraft/server/server.properties

if [ -z "${DIFFICULTY}" ]; then
	DIFFICULTY="normal"
fi
if [ ${DIFFICULTY} = "hard" ];then
	DIFFICULTY="hard"
elif [ ${DIFFICULTY} = "peaceful" ];then
	DIFFICULTY="peaceful"
elif [ ${DIFFICULTY} = "easy" ];then
	DIFFICULTY="easy"
else
	DIFFICULTY="normal"
fi

if [ -z "${GAMEMODE}" ]; then
	GAMEMODE="creative"
fi
if [ ${GAMEMODE} = "creative" ];then
	GAMEMODE="creative"
else
	GAMEMODE="survival"
fi

if [ -z "${PERMISSION}" ]; then
	DIFFICULTY="operator"
fi

if [ "${PERMISSION}" = "visitor" ]; then
	DIFFICULTY="visitor"
elif [ "${PERMISSION}" = "member" ]; then
	DIFFICULTY="member"
else
	DIFFICULTY="operator"
fi

sed -i -e "s/=v=srvid=v=/${SRVID}/g" /minecraft/server/server.properties
sed -i -e "s/=v=difficulty=v=/${DIFFICULTY}/g" /minecraft/server/server.properties
sed -i -e "s/=v=gamemode=v=/${GAMEMODE}/g" /minecraft/server/server.properties
sed -i -e "s/=v=permission=v=/${PERMISSION}/g" /minecraft/server/server.properties

echo "make properties process....done" >&1
