FROM debian:jessie
MAINTAINER Massimiliano Ravelli <massimiliano.ravelli@gmail.com>


RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

ENV BUILD_DEPENDENCIES="curl python-pip build-essential python-dev"

RUN    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && apt-get update \
    && apt-get install -y python2.7 $BUILD_DEPENDENCIES \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && pip install uWSGI==2.0.9 \
    && apt-get --purge -y remove $BUILD_DEPENDENCIES \
    && apt-get --purge -y autoremove
