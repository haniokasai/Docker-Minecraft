#!/bin/bash

echo "Prepare ftp...." >&1


groupadd ftpgroup
adduser ftpuser --gecos ""  --shell /bin/false --home /minecraft/server --no-create-home --disabled-password
usermod ftpuser -G ftpgroup

cd /etc/pure-ftpd/conf

#タイミング悪くね！作成時にパスワードじゃ間に合わん。
cd /tmp
#echo "${SRVID}:${PASSWD}" > passwdlist
#pure-pw useradd ${SRVID} -f passwdlist -u ftpuser -d /minecraft/server
#https://github.com/nexeck/docker-pure-ftpd/blob/30a982aea4e9fb6b5fba6776fceccb15cb39bd04/docker-entrypoint.sh
expect -c "
  spawn pure-pw useradd ${SRVID} -u ftpuser -g ftpgroup -d ${FTP_DIR}/data
  expect {
    Password {
      send \"${PASSWD}\r\"
      exp_continue
    }
    again {
      send \"${PASSWD}\r\"
      exp_continue
    }
  }
"
pure-pw mkdb && \
ln -s /etc/pure-ftpd/pureftpd.passwd /etc/pureftpd.passwd && \
ln -s /etc/pure-ftpd/pureftpd.pdb /etc/pureftpd.pdb && \
ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/PureDB && \
chown -hR ftpuser:ftpgroup /minecraft/server
#rm passwdlist
echo "Prepare ftp....done" >&1
