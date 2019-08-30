FROM ubuntu:19.04
MAINTAINER haniokasai <htek@haniokasai.com>


ENV DEBIAN_FRONTEND=noninteractive

# RUN: when image is being built
RUN echo "BUILDING PROCESS"
RUN apt update
RUN apt install pure-ftpd zip rsync unzip -y

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
##Minecraft
EXPOSE 19132/udp
EXPOSE 19132/tcp
##Cuberite Admin
EXPOSE 80/tcp

#Copy
COPY ./resources/*  /minecraft/resources/
#ADD ./resources/*  /minecraft/resources/

#Minecraft and FTP
WORKDIR /minecraft/server

RUN groupadd ftpgroup &&\
	useradd -g ftpgroup -d /minecraft/server -s /dev/null ftpuser
CMD sh /minecraft/resources/run-Main.sh
