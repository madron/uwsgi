#!/bin/sh
set -e

if [[ "$1" = "uwsgi" ]]; then
    echo exec gosu uwsgi "$@"
fi

exec "$@"
