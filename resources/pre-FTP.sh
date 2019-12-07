#!/bin/bash
echo "Prepare ftp...." >&1

#config
sh /minecraft/resources/config-FTP.sh
mkdir -p /run/sshd
 
groupadd ftpgroup
ftp_login=${SRVID}
ftp_pass=${PASSWD}
CRYPTED_PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $ftp_pass)
useradd --shell /bin/bash -d /minecraft/server --password $CRYPTED_PASSWORD $ftp_login
usermod $ftp_login -G ftpgroup

unset ftp_pass
unset PASSWD

touch /minecraft/bin/nonftp
echo "Prepare ftp....done" >&1
