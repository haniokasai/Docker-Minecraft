#!/bin/sh
echo "run vanilla...." >&1

sh /minecraft/resources/setPerm.sh
cd /minecraft/server
echo "if you do not agree eura, please stop now...." >&1
echo "eula=true" > eula.txt
java -jar /minecraft/bin/mcpc.jar nogui
echo "run vanilla....done" >&1

