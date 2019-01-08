FROM python:3.7.2-slim-stretch

ARG UWSGI_VERSION=2.0.17.1

RUN    /bin/true \
    \
    # Required packages
    && apt-get update \
    && apt-get install -y gosu nginx gcc \
    \
    # uWSGI
    && pip3 install uwsgi==$UWSGI_VERSION \
    \
    # Cleanup
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y --purge remove gcc \
    && apt-get -y --purge autoremove \
    \
    # forward nginx logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    \
    && /bin/true

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
