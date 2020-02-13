#!/bin/sh
rm -rf /smx/docker_minecraft_res/*
sh getFiles.sh
cp resources/* /smx/docker_minecraft_res/
cd /smx/docker_minecraft_res/
mkdir bdssync
cd bdssync
unzip ../bds.zip