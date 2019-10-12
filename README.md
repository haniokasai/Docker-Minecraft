# Docker-Minecraft
Docker for Minecraft

# TODO
- IP制限
- SFTP

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
chmod +x getFiles.sh
sh getFiles.sh
docker build . -t haniokasai/docker-minecraft
```

# Sysinstall

```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

# 奇妙な設計問題

## １．/minecraft/bin/nonftp
このファイルの有無でftpのon/off　が決まります <br>
- FTPのオフ
	docker exec で touch /minecraft/bin/nonftp <br>
- FTPのオン
	docker exec で rm -rf /minecraft/bin/nonftp <br>

## 2 更新を要求されるファイルたち
Dockerのイメージはインターネットからファイルを取得できません<br>
ホストがコンテナ内にファイルをコピーしてやる必要があります。<br>
- /minecraft/resources/bds.zip
- /minecraft/resources/cuberite*.tar.gz
- /minecraft/resources/PHP*.tar.gz
- /minecraft/resources/defaultplugins*.tar.gz
- /minecraft/server/pmmp.phar
これらのファイルは<br>
docker execで rm -rf それ<br>
docker cp ホスト/それ　コンテナ/それ<br>
で設置します。圧縮ファイル内のフォルダ構造は維持されないといけません。



# ファイル構造
## 非ユーザー領域
- /minecraft/  当イメージ的にはroot
- /minecraft/bin/ バイナリ置き場
- /minecraft/defaultplugins/ デフォルトプラグインを並べる。PMMP起動時、rsyncでコピられる
- /minecraft/resources/  リソースの置き場。ビルド時にホストとの媒介のため。
- /minecraft/resources/bds.zip
- /minecraft/resources/cuberite*.tar.gz
- /minecraft/resources/PHP*.tar.gz
- /minecraft/resources/defaultplugins*.tar.gz
## ユーザー領域
- /minecraft/server/ サーバーデータ、FTPアクセス可能

## 識別子
- /minecraft/buildnow 初回ビルド時に削除されるフラグ、あるとrun-Mainが何もしない
- /minecraft/initialstart  初回起動時に削除されるフラグ、あるとrun-Mainで初期化を実施する
- /minecraft/nonftp FTPのオフ とオンフラグ　あるとPMMPプラグインがsyncされる
# Reference
[atmoz/sftp](https://github.com/atmoz/sftp)
[chriskte, pure-ftpd-docker](https://github.com/chriskite/pure-ftpd-docker)
