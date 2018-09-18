FROM debian:stretch-backports

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

ENV http_proxy ${http_proxy}

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
