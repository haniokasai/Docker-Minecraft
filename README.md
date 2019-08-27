# Docker-Minecraft
Docker for Minecraft

```bash
docker create --name=コンテナ名 \
	--storage-opt size=0.5g --memory-size 100M --CPU 0.3\
	-p 19132:"(MiRmでportを配当40000番台、Minecraft)" -p 22:"(MiRmでportを配当5万番台、FTP)" -p  8080:"(MiRmでportを配当30000番台、WebパネorIpv6)"   \
	-e SRVTYPE="(pmmp,beof,cuberite)"\
	-e SRVID=サーバー名 -e PASSWD=生パスワード -e OPNAME=OP名 -e GAMEMODE=ゲームモード -e WORLDTYPE=ワールド -e DIFFICULTY=難易度 -e PERMISSION=権限  -e SRVDOMAIN=サーバーのドメイン \
	-itd haniokasai/Docker-Minecraft
```

# File 構成(置き換え)
- /minecraft/resources/bds.zip
- /minecraft/resources/cuberite*.tar.gz
- /minecraft/resources/PHP*.tar.gz
- /minecraft/resources/defaultplugins*.tar.gz
- /minecraft/server/pmmp.phar

# FTPのオンオフ
- /minecraft/bin/nonftp

# TODO
- IP制限
 

# Reference

[chriskte, pure-ftpd-docker](https://github.com/chriskite/pure-ftpd-docker)



