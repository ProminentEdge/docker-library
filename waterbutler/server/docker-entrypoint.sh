#!/bin/bash
set -e

if [[ "$1" = invoke-* ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    git reset --hard 04df0857b34fa3f9b14491067c169b7c17132408
    pip install -r requirements.txt
    chown -R python /code

    if [ "$1" = 'invoke-celery' ]; then
        echo "Starting Celery"
        exec gosu python bash -c "invoke celery"
    fi

    if [ "$1" = 'invoke-server' ]; then
        echo "Starting Server"
        exec gosu python bash -c "invoke server"
    fi
fi

exec gosu python bash -c "$@"