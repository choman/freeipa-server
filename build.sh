#!/bin/bash

#
# not using docker-compose yet
which docker-compose > /dev/null
which docker-compose2 > /dev/null
rval=$?

if [ $rval -eq 1 ]; then
    cd  docker-freeipa
    docker build -t freeipa-server -f Dockerfile.centos-7 .

else
    docker-compose build
fi
