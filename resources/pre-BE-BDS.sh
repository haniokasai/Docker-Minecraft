#!/bin/sh
echo "pre process...." >&1

#liblary
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local-lib.conf
echo "LD_LIBRARY_PATH=/usr/local/lib/" >> /etc/environment

sh /minecraft/resources/make_Properties_BDS.sh

bash /minecraft/resources/BDS_copyworld.bash

echo "pre process....done" >&1
