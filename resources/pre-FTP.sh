#!/bin/bash

echo "Prepare ftp...." >&1


groupadd ftpgroup &&\
	
#https://qiita.com/dogyear/items/e58ddab9a49bf82ed43f
expect -c "
spawn useradd -g ftpgroup -d /minecraft/server -s /dev/null ftpuser
expect \"Password:\"
send -- \"aaaa\n\"
expect \"Enter it again:\"
send -- \"aaaa\n\"
"

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
