#!/bin/sh
echo "pre process...." >&1
WDIR=/minecraft/bin
mkdir -p ${WDIR}/cube
cd ${WDIR}/cube
cp /minecraft/resources/cuberite*.tar.gz ${WDIR}/cube/cuberite.tar.gz
tar zxvf cuberite.tar.gz
cp ${WDIR}/cube/cuberite_binfile /minecraft/bin/cuberite_binfile
cp -rp ${WDIR}/cube/cuberite_src/* /minecraft/server/
cd /minecraft/server
rm -rf ${WDIR}/cube
#config
mv /minecraft/server/webadmin.ini.def /minecraft/server/webadmin.ini
sed -i -e "s/=v=Ports=v=/8080/g" webadmin.ini
sed -i -e "s/=v=srvid=v=/${SRVID}/g" webadmin.ini
sed -i -e "s/=v=Password=v=/${PASSWD}/g" webadmin.ini

mv /minecraft/server/settings.ini.def /minecraft/server/settings.ini
sed -i -e "s/=v=Description=v=/${SRVID} [MiRm-Cuberite]/g" settings.ini
sed -i -e "s/=v=MaxPlayers=v=/30/g" settings.ini
sed -i -e "s/=v=Ports=v=/25565/g" settings.ini

echo "pre process....done" >&1
