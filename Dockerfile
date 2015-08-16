FROM nginx:1.9.3
MAINTAINER Massimiliano Ravelli <massimiliano.ravelli@gmail.com>

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi


# Gosu
RUN    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && apt-get purge -y --auto-remove curl


# Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip python-dev libpcre3-dev \
    && rm -rf /var/lib/apt/lists/*


# uWSGI
RUN pip install uWSGI==2.0.11.1 gevent==1.0.2


COPY entrypoint.sh /

VOLUME ["/run/uwsgi"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
