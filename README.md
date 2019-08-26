# Docker-Minecraft
Docker for Minecraft

```bash
docker create --name=コンテナ名 \
    --storage-opt size=0.5g --memory-size 100M --CPU 0.3\
    -v /steadym/sys/multiphar:/minecraft/multiphar:ro -v /steadym/sys/plugins_3:/minecraft/defaultplugins:ro\ 
    -p 19132:"(MiRmでportを配当40000番台、Minecraft)" -p 22:"(MiRmでportを配当5万番台、FTP)" -p  8080:"(MiRmでportを配当30000番台、WebパネorIpv6)"   \
    -e SRVTYPE="(pmmp,beof,cuberite)"\
    -e PHARNAME="phar名 or mochikomi" \
    -e SRVID=サーバー名 -e PASSWD=生パスワード -e OPNAME=OP名 -e GAMEMODE=ゲームモード -e WORLDTYPE=ワールド -e DIFFICULTY=難易度 -e PERMISSION=権限   \
    -itd haniokasai/Docker-Minecraft
```


# Reference:
[chriskte, pure-ftpd-docker](https://github.com/chriskite/pure-ftpd-docker)
