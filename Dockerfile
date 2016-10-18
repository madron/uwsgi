FROM alpine:edge

MAINTAINER Massimiliano Ravelli <massimiliano.ravelli@gmail.com>

RUN    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add python3 \
    && apk add uwsgi-python3==2.0.14-r2 \
    && apk add gosu@testing \
    && apk add nginx \
    && rm -rf /var/cache/apk/* \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]
