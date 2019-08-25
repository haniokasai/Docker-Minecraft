#!/bin/sh
if [[ -z "${SRVTYPE}" ]]; then
	echo "SRVTYPE is not setted"
	exit 1
fi

############
#Permission#
############
chgrp ftpgroup /minecraft/server -R
chmod 2111 /minecraft/resources -R
chmod 2111 /minecraft/bin -R
chmod 2777 /minecraft/server -R
###########
#Start FTP#
###########
exec /usr/sbin/pure-ftpd -l pam -l puredb:/etc/pure-ftpd/pureftpd.pdb 1000 -8 UTF-8 --noanonymous --userbandwidth --quota 10000:15 &
echo $! > /minecraft/bin/pureftpd.pid


###########
#Minecraft#
###########
cd /minecraft/server
if [ "${SRVTYPE}" is "pmmp" ]; then
	sh /minecraft/resources/run-BE-PMMP.sh
	
elif [ "${SRVTYPE}" is "beof" ]; then
	sh /minecraft/resources/run-BE-BDS.sh

elif [ "${SRVTYPE}" is "cuberite" ]; then
	sh /minecraft/resources/run-BE-Cuberite.sh

elif [ "${SRVTYPE}" is "mcpc" ]; then
	sh /minecraft/resources/run-MCPC.sh

elif [ "${SRVTYPE}" is "spigot" ]; then
	sh /minecraft/resources/run-SPIG.sh

else
	echo 'Invalid SRVTYPE!' >&2
	ER="true"
fi

#########
#StopFTP#
#########
kill -9 `cat /minecraft/bin/pureftpd.pid`
rm /minecraft/bin/*.pid

if [[ -z "${ER}" ]]; then
	exit 1
else
	exit 0
fi