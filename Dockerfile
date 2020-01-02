FROM alpine:3.11

RUN    apk --no-cache add su-exec==0.2-r1 uwsgi-python==2.0.18-r4 nginx==1.16.1-r4 \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
