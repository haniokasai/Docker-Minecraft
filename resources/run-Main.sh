#!/bin/sh
if [ -z "${SRVTYPE}" ]; then
	echo "SRVTYPE is not setted" >&2
	exit 1
fi



#############
#InitProcess#
#############
if [ -e /minecraft/bin/buildnow ]; then # aaa,txtはあるか？
	echo "This is first build" >&1
	exit 0
fi
if [ -e /minecraft/initialstart ]; then # aaa,txtはあるか？
	echo "Initial Start..." >&1
	#-----------#
	#FTP prepare#
	#-----------#
	if [ -z "${SRVID}" ]; then
		echo "SRVID is not setted" >&2
		exit 1
	fi
	if [ -z "${PASSWD}" ]; then
		echo "PASSWD is not setted" >&2
		exit 1
	fi

	sh /minecraft/resources/pre-FTP.sh
	#-----------------#
	#Minecraft Prepare#
	#-----------------#

	if [ "${SRVTYPE}" =  "pmmp" ]; then
		#WORLDTYPE, GAMEMODE, SRVDOMAIN
		echo "Preparation pmmp has been selected." >&1
		sh /minecraft/resources/pre-BE-PMMP.sh
	elif [ "${SRVTYPE}" =  "beof" ]; then
		#DIFFICULTY, GAMEMODE, PERMISSION
		echo "Preparation BDS has been selected." >&1
		sh /minecraft/resources/pre-BE-BDS.sh
	elif [ "${SRVTYPE}" =  "cuberite" ]; then
		echo "Preparation cuberite has been selected." >&1
		sh /minecraft/resources/pre-BE-Cuberite.sh
	elif [ "${SRVTYPE}" =  "mcpc" ]; then
		echo "NOT implement Preparation mcpc has been selected." >&1
		sh /minecraft/resources/pre-MCPC.sh
	elif [ "${SRVTYPE}" =  "spigot" ]; then
		echo "NOT implement Preparation spigot has been selected." >&1
		sh /minecraft/resources/pre-SPIG.sh
	else
		echo 'Invalid SRVTYPE!' >&2
		ER="true"
	fi
	echo "Initial Start...done" >&1
fi

#############
#Permission #
#############
sh /minecraft/resources/setPerm.sh

############
#Start FTP #
############
if [ ! -e "/minecraft/nonftp"  ]; then
	echo "Starting PureFTPd..." >&1
	exec /usr/sbin/pure-ftpd -l pam -l puredb:/etc/pure-ftpd/pureftpd.pdb 1000 -8 UTF-8 --noanonymous --userbandwidth --quota 10000:15 &
	echo $! > /minecraft/bin/pureftpd.pid
	echo "Starting PureFTPd...done" >&1
fi

############
#Minecraft #
############
echo "Main Server Start..." >&1
cd /minecraft/server
rm -rf /minecraft/server/resource_packs
if [ "${SRVTYPE}" =  "pmmp" ]; then
	echo "Starter pmmp has been selected." >&1
	sh /minecraft/resources/run-BE-PMMP.sh
elif [ "${SRVTYPE}" =  "beof" ]; then
	echo "Starter beof has been selected." >&1
	sh /minecraft/resources/run-BE-BDS.sh
elif [ "${SRVTYPE}" = "cuberite" ]; then
	echo "Starter cuberite has been selected." >&1
	sh /minecraft/resources/run-BE-Cuberite.sh
elif [ "${SRVTYPE}" =  "mcpc" ]; then
	echo "Starter mcpc has been selected." >&1
	sh /minecraft/resources/run-MCPC.sh
elif [ "${SRVTYPE}" =  "spigot" ]; then
	echo "Starter spigot has been selected." >&1
	sh /minecraft/resources/run-SPIG.sh
else
	echo 'Invalid SRVTYPE!' >&2
	ER="true"
fi
echo "Main Server Start...done" >&1

##########
#Stop FTP#
##########
echo "Stopping PureFTPd..." >&1
kill -9 `cat /minecraft/bin/pureftpd.pid`
rm /minecraft/bin/*.pid
echo "Stopping PureFTPd...done" >&1

if [ -z "${ER}" ]; then
	echo "Shutdown..." >&2
	exit 1
else
	echo "Shutdown..." >&1
	exit 0
fi