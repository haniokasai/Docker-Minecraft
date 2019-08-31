FROM ubuntu:19.04
MAINTAINER haniokasai <htek@haniokasai.com>


ENV DEBIAN_FRONTEND=noninteractive

# RUN: when image is being built
RUN apt update
RUN apt install zip rsync unzip expect proftpd perl -y

#Make necessary dirs
RUN mkdir /minecraft
RUN mkdir /minecraft/resources
RUN mkdir /minecraft/bin
RUN mkdir /minecraft/server
##These dirs are for PM-MP there should be mounted.
RUN mkdir /minecraft/multiphar
RUN mkdir /minecraft/defaultplugins
##Initial flag
RUN touch /minecraft/initialstart
RUN touch /minecraft/buildnow

#PORT
##FTP
EXPOSE 21/tcp
EXPOSE 20/tcp

##Minecraft
EXPOSE 19132/udp
EXPOSE 25565/tcp
##Cuberite Admin
EXPOSE 80/tcp

#Copy
COPY ./resources/*  /minecraft/resources/

#Minecraft and FTP
WORKDIR /minecraft/server
CMD sh /minecraft/resources/run-Main.sh
