#!/bin/bash

# awesome
dockerfile=$(basename ${1-Dockerfile.centos-7})

#
# not using docker-compose yet
which docker-compose > /dev/null
which docker-compose2 > /dev/null
rval=$?

if [ $rval -eq 1 ]; then
    echo "using: docker" ; sleep 2
    cd  docker-freeipa
    docker build -t freeipa-server -f Dockerfile.centos-7 .

else
    echo "using: docker-compose" ; sleep 2
    docker-compose build
fi
