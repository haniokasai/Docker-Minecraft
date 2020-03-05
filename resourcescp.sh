#!/bin/sh
git checkout .
git pull
chmod +x *
rm -rf /smx/docker_minecraft_res/*
sh getFiles.sh
cp resources/* /smx/docker_minecraft_res/
cd /smx/docker_minecraft_res/
mkdir bdssync
cd bdssync
unzip ../bds.zip
rm /smx/sys/multiphar/pmmp_default.phar
cp resources/pmmp_*.phar /smx/sys/ /smx/sys/multiphar/