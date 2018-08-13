#!/bin/sh
set -e

if [[ "$1" = "uwsgi" ]]; then
    exec su-exec uwsgi "$@"
elif [[ "$1" = "nginx" ]]; then
    exec nginx -g "daemon off;"
fi

exec "$@"
