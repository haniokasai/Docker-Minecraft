#!/bin/bash
echo "run vanilla...." >&1

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockUDP.sh

cd /minecraft/server
echo "if you do not agree eura, please stop now...." >&1
echo "eula=true" > eula.txt
i=(`awk '/^Mem/ {printf("%u", $7);}' <(free -m)`)
java -jar /minecraft/bin/mcpc.jar -Xmx$((i/10*7))m nogui
echo "run vanilla....done" >&1

