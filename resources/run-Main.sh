#!/bin/sh
if [[ -z "${SRVTYPE}" ]]; then
	echo "SRVTYPE is not setted"
	exit 1
fi


#############
#InitProcess#
#############
if [ -e /minecraft/bin/initialstart ]; then # aaa,txtはあるか？
	echo "Initial Start..." >&1
	#-----------#
	#FTP prepare#
	#-----------#
	if [[ -z "${SRVID}" ]]; then
	echo "SRVID is not setted"
	exit 1
    fi
    if [[ -z "${PASSWD}" ]]; then
	echo "PASSWD is not setted"
	exit 1
    fi

	sh pre-FTP.sh
	#-----------------#
	#Minecraft Prepare#
	#-----------------#

	if [ "${SRVTYPE}" -eq  "pmmp" ]; then
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
	    sh /minecraft/resources/pre-BE-PMMP.sh

    elif [ "${SRVTYPE}" -eq  "beof" ]; then
	    sh /minecraft/resources/pre-BE-BDS.sh

    elif [ "${SRVTYPE}" -eq  "cuberite" ]; then
	    sh /minecraft/resources/pre-BE-Cuberite.sh

    elif [ "${SRVTYPE}" -eq  "mcpc" ]; then
	    sh /minecraft/resources/pre-MCPC.sh

    elif [ "${SRVTYPE}" -eq  "spigot" ]; then
	    sh /minecraft/resources/pre-SPIG.sh

    else
	    echo 'Invalid SRVTYPE!' >&2
	    ER="true"
    fi

fi

#############
#Permission #
#############
chgrp ftpgroup /minecraft/server -R
chmod 2111 /minecraft/resources -R
chmod 2111 /minecraft/bin -R
chmod 2777 /minecraft/server -R
############
#Start FTP #
############
exec /usr/sbin/pure-ftpd -l pam -l puredb:/etc/pure-ftpd/pureftpd.pdb 1000 -8 UTF-8 --noanonymous --userbandwidth --quota 10000:15 &
echo $! > /minecraft/bin/pureftpd.pid


############
#Minecraft #
############
cd /minecraft/server
rm -rf /minecraft/server/resource_packs
if [ "${SRVTYPE}" -eq  "pmmp" ]; then
	sh /minecraft/resources/run-BE-PMMP.sh
	
elif [ "${SRVTYPE}" -eq  "beof" ]; then
	sh /minecraft/resources/run-BE-BDS.sh

elif [ "${SRVTYPE}" = "cuberite" ]; then
	sh /minecraft/resources/run-BE-Cuberite.sh

elif [ "${SRVTYPE}" -eq  "mcpc" ]; then
	sh /minecraft/resources/run-MCPC.sh

elif [ "${SRVTYPE}" -eq  "spigot" ]; then
	sh /minecraft/resources/run-SPIG.sh

else
	echo 'Invalid SRVTYPE!' >&2
	ER="true"
fi

##########
#Stop FTP#
##########
kill -9 `cat /minecraft/bin/pureftpd.pid`
rm /minecraft/bin/*.pid

if [[ -z "${ER}" ]]; then
	exit 1
else
	exit 0
fi