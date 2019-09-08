#!/bin/sh
if [ -z "${SRVTYPE}" ]; then
	echo "SRVTYPE is not setted" >&2
	exit 1
fi



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
	#Block Outgoing   #
	#-----------------#
	#sshは抜こう
	iptables -A OUTPUT -p tcp --dport 1:1023 -j REJECT --reject-with tcp-reset
	iptables -A OUTPUT -p udp --dport 1:1023 -j DROP
	iptables -A OUTPUT -p tcp --dport 1:1023 -j DROP
	iptables -A OUTPUT -p icmp -j DROP
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
	rm -rf /minecraft/initialstart
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
	echo "Starting sftpd..." >&1
	exec /usr/sbin/sshd -D -e &
	echo $! > /minecraft/bin/sftpd.pid
	cat /minecraft/bin/sftpd.pid
	echo "Starting sftpd...done" >&1
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
echo "Stopping sftpd..." >&1
cat /minecraft/bin/sftpd.pid
kill -9 `cat /minecraft/bin/sftpd.pid`
rm /minecraft/bin/*.pid
echo "Stopping sftpd...done" >&1

if [ -z "${ER}" ]; then
	echo "Shutdown..." >&2
	exit 1
else
	echo "Shutdown..." >&1
	exit 0
fi