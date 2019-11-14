#!/bin/sh
echo "run rsync...." >&1

mkdir -p /minecraft/defaultplugins/
tar zxvf /minecraft/resources/defaultplugins.tar.gz -C /minecraft/defaultplugins/
rsync -aq  --include="*/" --include="*.phar" --exclude="*" /minecraft/defaultplugins/ /minecraft/server/plugins --delete
echo "run rsync....done" >&1
