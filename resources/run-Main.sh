#!/bin/sh
if [[ -z "${SRVTYPE}" ]]; then
	echo "SRVTYPE is not setted"
	exit 1
fi


#############
#InitProcess#
#############
if [[ -e /minecraft/bin/initialstart ]]; then # aaa,txtはあるか？
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

	if [[ "${SRVTYPE}" -eq  "pmmp" ]]; then
		#WORLDTYPE, GAMEMODE, SRVDOMAIN
		sh /minecraft/resources/pre-BE-PMMP.sh

	elif [[ "${SRVTYPE}" -eq  "beof" ]]; then
		#DIFFICULTY, GAMEMODE, PERMISSION
		sh /minecraft/resources/pre-BE-BDS.sh

	elif [[ "${SRVTYPE}" -eq  "cuberite" ]]; then
		sh /minecraft/resources/pre-BE-Cuberite.sh

	elif [[ "${SRVTYPE}" -eq  "mcpc" ]]; then
		sh /minecraft/resources/pre-MCPC.sh

	elif [[ "${SRVTYPE}" -eq  "spigot" ]]; then
		sh /minecraft/resources/pre-SPIG.sh

	else
		echo 'Invalid SRVTYPE!' >&2
		ER="true"
	fi

fi

#############
#Permission #
#############
sh /minecraft/resources/setPerm.sh

############
#Start FTP #
############
if [[ ! -e "/minecraft/bin/nonftp"  ]]; then
	exec /usr/sbin/pure-ftpd -l pam -l puredb:/etc/pure-ftpd/pureftpd.pdb 1000 -8 UTF-8 --noanonymous --userbandwidth --quota 10000:15 &
	echo $! > /minecraft/bin/pureftpd.pid
fi

############
#Minecraft #
############
cd /minecraft/server
rm -rf /minecraft/server/resource_packs
if [[ "${SRVTYPE}" -eq  "pmmp" ]]; then
	sh /minecraft/resources/run-BE-PMMP.sh
	
elif [[ "${SRVTYPE}" -eq  "beof" ]]; then
	sh /minecraft/resources/run-BE-BDS.sh

elif [[ "${SRVTYPE}" = "cuberite" ]]; then
	sh /minecraft/resources/run-BE-Cuberite.sh

elif [[ "${SRVTYPE}" -eq  "mcpc" ]]; then
	sh /minecraft/resources/run-MCPC.sh

elif [[ "${SRVTYPE}" -eq  "spigot" ]]; then
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