FROM ubuntu:19.04
MAINTAINER haniokasai <htek@haniokasai.com>


ENV DEBIAN_FRONTEND=noninteractive

# RUN: when image is being built
#apt srv https://qiita.com/fkshom/items/53de3a9b9278cd524099
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt update
#curl for libcurl4 for bds
RUN apt install zip rsync unzip expect perl curl iptables openssh-server -y

#Make necessary dirs
RUN mkdir /minecraft
RUN mkdir /minecraft/resources
RUN mkdir /minecraft/bin
RUN mkdir /minecraft/server
##These dirs are for PM-MP there should be mounted.
RUN mkdir /minecraft/defaultplugins
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
WORKDIR /minecraft/server
CMD sh /minecraft/resources/run-Main.sh
