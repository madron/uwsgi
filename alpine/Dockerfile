FROM alpine:3.3

MAINTAINER Massimiliano Ravelli <massimiliano.ravelli@gmail.com>

RUN    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add py-pip \
    && apk add uwsgi-python==2.0.11.2-r0 \
    && apk add gosu@testing \
    && apk add nginx \
    && rm -rf /var/cache/apk/* \
    \
    # User
    && addgroup uwsgi \
    && adduser -S -G uwsgi uwsgi \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

# VOLUME ["/run/uwsgi"]
VOLUME ["/var/run", "/var/lib/nginx/tmp"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]
