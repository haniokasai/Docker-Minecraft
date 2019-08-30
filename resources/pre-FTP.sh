#!/bin/bash

echo "Prepare ftp...." >&1


#タイミング悪くね！作成時にパスワードじゃ間に合わん。
echo "${SRVID}:${PASSWD}" > passwdlist
pure-pw useradd ${SRVID} -u ftpuser -d /minecraft/server

pure-pw mkdb && \
ln -s /etc/pure-ftpd/pureftpd.passwd /etc/pureftpd.passwd && \
ln -s /etc/pure-ftpd/pureftpd.pdb /etc/pureftpd.pdb && \
ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/PureDB && \
chown -hR ftpuser:ftpgroup /minecraft/server
rm passwdlist
echo "Prepare ftp....done" >&1
