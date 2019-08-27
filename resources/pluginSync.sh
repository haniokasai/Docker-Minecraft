#!/bin/sh
mkdir -p /minecraft/defaultplugins/
tar zxvf /minecraft/resources/defaultplugins*.tar.gz /minecraft/bin
rsync -av  --include="*/" --include="*.phar" --exclude="*" /minecraft/defaultplugins/ /minecraft/server/plugins --delete
