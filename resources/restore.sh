#!/bin/sh
echo "restore...." >&1
directory=/minecraft/restore
#if exist file in folder
if [ -n "$(ls "${directory}")" ]; then
echo "restore ....find files in ${directory}" >&1
	if [ -e ${directory}/server/ ]; then
		echo "restore process....${directory}/server " >&1
		rm -rf /minecraft/server/*
		mkdir -p /minecraft/server/
		mv ${directory}/server/* /minecraft/server/
	else
		echo "restore process....${directory} " >&1
		rm -rf /minecraft/server/*
		mkdir -p /minecraft/server/
		mv ${directory}* /minecraft/server/
	fi
else
echo "restore ....${directory} is empty" >&1
fi

echo "restore ....done" >&1