FROM debian:stretch-backports

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

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
	&& apt-get clean
