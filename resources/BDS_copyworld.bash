#!/bin/bash
echo try_to_copying_world >&1

NUM=$(( $RANDOM % 5 + 1 ))
I=0
while [  ! -d /minecraft/resources/worlds/bds${NUM} ]
do
  echo /minecraft/resources/worlds/bds${NUM}
  echo $I
  I=`expr $I + 1`
  if [ $I -eq 10 ]; then
    echo no_world_found_in_resources_folder\ >&1
    exit 0
  fi
  NUM=$(( $RANDOM % 5 + 1 ))
done
echo world_has_been_founded >&1
if [ -d /minecraft/resources/worlds/bds${NUM} ]; then
    echo copying_folder >&1
    echo /minecraft/resources/worlds/bds${NUM} >&1
    mkdir -p /minecraft/server/worlds/level
    cp -r /minecraft/resources/worlds/bds${NUM}/* /minecraft/server/worlds/level
fi