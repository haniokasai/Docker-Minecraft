#!/bin/bash
echo "Prepare ftp...." >&1

#config
SSHDFILE=/etc/ssh/sshd_config
echo "Port 22" > ${SSHDFILE}
echo "PermitRootLogin yes" >> ${SSHDFILE}
echo "PasswordAuthentication yes" >> ${SSHDFILE}
echo "PermitEmptyPasswords no" >> ${SSHDFILE}
echo "UseDNS no" >> ${SSHDFILE}
echo "Subsystem sftp internal-sftp" >> ${SSHDFILE}
echo "UseDNS no" >> ${SSHDFILE}

echo "Match Group ftpgroup" >> ${SSHDFILE}
echo "X11Forwarding no" >> ${SSHDFILE}
echo "AllowTcpForwarding no" >> ${SSHDFILE}
echo "ChrootDirectory /minecraft/server" >> ${SSHDFILE}
echo "ForceCommand internal-sftp" >> ${SSHDFILE}
mkdir -p /run/sshd
 
groupadd ftpgroup
ftp_login=${SRVID}
ftp_pass=${PASSWD}
CRYPTED_PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $ftp_pass)
useradd --shell /bin/bash -d /minecraft/server --password $CRYPTED_PASSWORD $ftp_login
usermod $ftp_login -G ftpgroup

unset ftp_pass
unset ftp_login
unset PASSWD
unset SRVID
 
chown -hR $ftp_login:ftpgroup /minecraft/server

touch /minecraft/bin/nonftp
echo "Prepare ftp....done" >&1
