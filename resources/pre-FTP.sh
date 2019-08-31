#!/bin/bash
echo "Prepare ftp...." >&1

groupadd ftpgroup
ftp_login=${SRVID}
ftp_pass=${PASSWD}
CRYPTED_PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $ftp_pass)
useradd --shell /bin/sh -d /minecraft/server --password $CRYPTED_PASSWORD $ftp_login
usermod $ftp_login -G ftpgroup

chown -hR $ftp_login:ftpgroup /minecraft/server

echo "Prepare ftp....done" >&1
