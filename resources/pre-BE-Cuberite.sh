#!/bin/sh
echo "pre process...." >&1

WDIR=/minecraft/resources
tar zxvf ${WDIR}/cuberite*.tar.gz
mv ${WDIR}/resources/cuberite_binfile /minecraft/bin/cuberite_binfile
mv ${WDIR}/resources/cuberite_src/* /minecraft/server/

#config
cd /minecraft/server
mv /minecraft/server/webadmin.ini.def /minecraft/server/webadmin.ini
sed -i -e "s/=v=Ports=v=/8080/g" settings.ini
sed -i -e "s/=v=srvid=v=/${SRVID}/g" settings.ini
sed -i -e "s/=v=Password=v=/${PASSWD}/g" settings.ini

mv /minecraft/server/settings.ini.def /minecraft/server/settings.ini
sed -i -e "s/=v=Description=v=/${SRVID} [MiRm-Cuberite]/g" settings.ini
sed -i -e "s/=v=MaxPlayers=v=/30/g" settings.ini
sed -i -e "s/=v=Ports=v=/19132/g" settings.ini

echo "pre process....done" >&1
