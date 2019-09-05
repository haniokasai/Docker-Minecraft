# Docker-Minecraft
Docker for Minecraft

```bash
docker create --name=コンテナ名 \
	--storage-opt size=0.5g --memory 100M --cpus 0.3 --cap-add=NET_ADMIN \
	-p 19132:"(MiRmでportを配当40000番台、Minecraft)" -p 22:"(MiRmでportを配当5万番台、FTP)" -p  8080:"(MiRmでportを配当30000番台、WebパネorIpv6)"   \
	-e SRVTYPE="(pmmp,beof,cuberite)"\
	-e SRVID=サーバー名 -e PASSWD=生パスワード -e OPNAME=OP名 -e GAMEMODE=ゲームモード -e WORLDTYPE=ワールド -e DIFFICULTY=難易度 -e PERMISSION=権限  -e SRVDOMAIN=サーバーのドメイン \
	-itd haniokasai/docker-minecraft
```

```bash
docker create --cap-add=NET_ADMIN --name=new --storage-opt size=0.5g -p 20001:19132/udp -p 20002:22 -p  20003:8080  -e SRVTYPE=pmmp -e SRVID=new -e PASSWD=test -it haniokasai/docker-minecraft　(
```

```bash
docker build . -t haniokasai/docker-minecraft

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



# Sysinstall

```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```