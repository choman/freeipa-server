#!/bin/bash

cd  docker-freeipa
docker build -t freeipa-server -f Dockerfile.centos-7 .
