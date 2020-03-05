#!/bin/sh
if [ -z "${SRVTYPE}" ]; then
	echo "SRVTYPE is not setted" >&2
	exit 1
fi

#############
#Del Tmpdir #
#############
rm -rf /tmp/*

#############
#ChkDisk    #
#############
bash /minecraft/resources/echoStorage.sh

#############
#InitProcess#
#############
ls /minecraft/resources
if [ -e /minecraft/buildnow ]; then # aaa,txtはあるか？
	echo "This is first build" >&1
	rm -rf /minecraft/buildnow
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
		sh -c "bash /minecraft/resources/run-BE-BDS.sh"
	elif [ "${SRVTYPE}" =  "cuberite" ]; then
		echo "Preparation cuberite has been selected." >&1
		sh /minecraft/resources/pre-PC-Cuberite.sh
	elif [ "${SRVTYPE}" =  "mcpc" ]; then
		echo "Preparation mcpc has been selected." >&1
		sh  /minecraft/resources/pre-PC-vanilla.sh
	elif [ "${SRVTYPE}" =  "spigot" ]; then
		echo " Preparation spigot has been selected." >&1
		sh  /minecraft/resources/pre-PC-vanilla.sh
	elif [ "${SRVTYPE}" =  "bukkit" ]; then
		echo " Preparation bukkit has been selected." >&1
		sh  /minecraft/resources/pre-PC-vanilla.sh
	else
		echo 'Invalid SRVTYPE!' >&2
		ER="true"
	fi
	rm -rf /minecraft/initialstart
	echo "Initial Start...done" >&1
fi

###############
#Unset Secrets#
###############
unset ftp_pass
unset PASSWD

#-----------------#
#Block Outgoing   #
#-----------------#
sh /minecraft/resources/blockOutgoing.sh


#############
#Init folder#
#############
mkdir -p /minecraft/restore

#############
#Restore    #
#############
sh /minecraft/resources/restore.sh

#############
#Permission #
#############
sh /minecraft/resources/setPerm.sh

############
#Start FTP #
############
if [ ! -e "/minecraft/bin/nonftp"  ]; then
	sh /minecraft/resources/run-FTP.sh
fi

############
#Minecraft #
############
echo "Main Server Start..." >&1

#ChkDisk
bash /minecraft/resources/echoStorage.sh

UNIXTIME_START=$(date +%s)

cd /minecraft/server
if [ "${SRVTYPE}" =  "pmmp" ]; then
	echo "Starter pmmp has been selected." >&1
	sh /minecraft/resources/run-BE-PMMP.sh
elif [ "${SRVTYPE}" =  "beof" ]; then
	echo "Starter beof has been selected." >&1
	sh /minecraft/resources/run-BE-BDS.sh
elif [ "${SRVTYPE}" = "cuberite" ]; then
	echo "Starter cuberite has been selected." >&1
	sh /minecraft/resources/run-PC-Cuberite.sh
elif [ "${SRVTYPE}" =  "mcpc" ]; then
	echo "Starter mcpc has been selected." >&1
	bash /minecraft/resources/run-PC-vanilla.sh
elif [ "${SRVTYPE}" =  "spigot" ]; then
	echo "Starter spigot has been selected." >&1
	bash /minecraft/resources/run-PC-vanilla.sh
elif [ "${SRVTYPE}" =  "bukkit" ]; then
	echo "Starter bukkit has been selected." >&1
	bash /minecraft/resources/run-PC-vanilla.sh
else
	echo 'Invalid SRVTYPE!' >&2
	ER="true"
fi

UNIXTIME_END=$(date +%s)

if [ "$((${UNIXTIME_END}-${UNIXTIME_START}))"  -gt 30 ]; then
	echo "Main Server Start...done" >&1
else
	echo "Main Server Start...failed" >&1
	echo "Waiting for User Action for 10 min..." >&1
	sleep 600
	echo "Waiting for User Action for 10 min...done" >&1
fi

##########
#Stop FTP#
##########
if [ ! -e "/minecraft/bin/nonftp"  ]; then

echo "Stopping sftpd..." >&1
cat /minecraft/bin/sftpd.pid
kill -9 `cat /minecraft/bin/sftpd.pid`
echo "Stopping sftpd...done" >&1

rm /minecraft/bin/*.pid

fi

#ChkDisk
bash /minecraft/resources/echoStorage.sh

if [ -z "${ER}" ]; then
	echo "Shutdown..." >&2
	exit 1
else
	echo "Shutdown..." >&1
	exit 0
fi

