#!/bin/bash
set -e

if [ "$1" = 'uwsgi' ]; then
    exec gosu uwsgi "$@"
fi

exec "$@"
