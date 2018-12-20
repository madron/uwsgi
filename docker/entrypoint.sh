#!/bin/sh
set -e

if [ "$1" = "uwsgi" ]; then
    exec gosu nobody "$@"
elif [ "$1" = "nginx" ]; then
    exec nginx -g "daemon off;"
fi

exec "$@"
