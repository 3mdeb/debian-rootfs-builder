FROM debian:stretch-backports

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

ARG HTTP_PROXY

ENV http_proxy ${HTTP_PROXY}

RUN \
	useradd -p locked -m debian && \
	apt-get -qq update && \
	apt-get -qqy -t stretch-backports install \
		ansible \
		bc \
		build-essential \
		ccache \
		debootstrap \
		kmod \
		libelf-dev \
		libssl-dev \
		lsb-release \
		python \
		unzip \
		tar \
	&& apt-get clean

ENV PATH="/usr/lib/ccache:${PATH}"
RUN mkdir /home/debian/.ccache && \
	chown debian:debian /home/debian/.ccache
WORKDIR /home/debian/scripts
RUN sed -i "s|#http_proxy = http://proxy.yoyodyne.com:18023/|http_proxy=${HTTP_PROXY}|g" /etc/wgetrc

# Temporary fix for tar problems in 1.0.100 version of debootstrap
COPY files/functions /usr/share/debootstrap/functions
