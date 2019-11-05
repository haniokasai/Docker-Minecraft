FROM ubuntu:19.04
MAINTAINER haniokasai <htek@haniokasai.com>


ENV DEBIAN_FRONTEND=noninteractive

# RUN: when image is being built
#apt srv https://qiita.com/fkshom/items/53de3a9b9278cd524099
RUN sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt update
#curl for libcurl4 for bds
RUN apt install zip rsync unzip expect perl curl iptables openssh-server openjdk-8-jre -y

#Make necessary dirs
RUN mkdir -p  /minecraft  /minecraft/resources /minecraft/bin /minecraft/server /minecraft/defaultplugins /var/run/fail2ban
##Initial flag
RUN touch /minecraft/initialstart
#RUN touch /minecraft/buildnow

#PORT Note: this is information for you. they are correct.
##SFTP
#EXPOSE 22/tcp

##Minecraft
#EXPOSE 19132/udp
#EXPOSE 25565/tcp
##Cuberite Admin
#EXPOSE 8080/tcp

#Copy
COPY ./resources/*  /minecraft/resources/

#Minecraft and FTP
WORKDIR /minecraft/resources/
ENTRYPOINT sh /minecraft/resources/run-Main.sh
