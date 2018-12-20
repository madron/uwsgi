FROM python:3.7.1-slim-stretch

RUN apt-get update && apt-get install -y \
    nginx=1.10.3-1+deb9u2 \
    gcc \
    uwsgi-plugin-python3=2.0.14+20161117-3+deb9u2 \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN pip3 install uwsgi==2.0.17.1

RUN apt-get clean

RUN useradd --no-create-home nginx

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
