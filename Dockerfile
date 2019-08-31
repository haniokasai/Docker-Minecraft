FROM ubuntu:19.04
MAINTAINER haniokasai <htek@haniokasai.com>


ENV DEBIAN_FRONTEND=noninteractive

# RUN: when image is being built
RUN apt update
RUN apt install zip rsync unzip expect -y

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
EXPOSE 25565/tcp
##Cuberite Admin
EXPOSE 80/tcp


#Copy
COPY ./resources/*  /minecraft/resources/

RUN apt --force-yes install dpkg-dev debhelper build-dep

# build from source https://github.com/chriskite/pure-ftpd-docker/blob/master/Dockerfile
RUN mkdir /tmp/pure-ftpd/ && \
	cd /tmp/pure-ftpd/ && \
	apt-get source pure-ftpd && \
	cd pure-ftpd-* && \
	sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
	dpkg-buildpackage -b -uc
RUN apt-mark hold pure-ftpd pure-ftpd-common

# install the new deb files
RUN dpkg -i /tmp/pure-ftpd/pure-ftpd-common*.deb
RUN apt-get -y install openbsd-inetd
RUN dpkg -i /tmp/pure-ftpd/pure-ftpd_*.deb

#Minecraft and FTP
WORKDIR /minecraft/server
CMD sh /minecraft/resources/run-Main.sh
