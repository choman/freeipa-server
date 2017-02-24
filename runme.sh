#!/bin/bash

. myenv
echo $REALM

#
# not using docker-compose yet
which docker-compose > /dev/null
which docker-compose2 > /dev/null
rval=$?


if [ ! -d "$DATADIR" ]; then
   sudo mkdir $DATADIR
fi

           #-p 53:53/udp -p 53:53 \
           #-p 123:123/udp \
           #--tmpfs /run --tmpfs /tmp \
           #-e IPA_SERVER_IP=$IPADDR \

if [ $rval -eq 1 ]; then
    echo "using: docker"
    docker run --name freeipa-server-container \
           --privileged \
           --restart always \
           -h $HOSTNAME \
           -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
           -v `pwd`/internal_scripts:/opt/scripts:ro \
           -v ${DATADIR}:/data:Z \
           --tmpfs /run --tmpfs /tmp \
           -p 80:80 \
           -p 443:443 \
           -p 389:389 -p 636:636 -p 88:88 -p 464:464 \
           -p 88:88/udp -p 464:464/udp \
           -p 7389:7389 \
           -p 9443:9443 -p 9444:9444 -p 9445:9445 \
           freeipa-server \
           --realm=$DOMAIN \
           --domain=$DOMAIN \
           --hostname=$HOSTNAME \
           --no-host-dns \
           --no-ntp \
           --ds-password=$DS_PASSWD \
           --admin-password=$ADMIN_PASSWD

else
    echo "using: docker-compose"
    export REALM DS_PASSWD ADMIN_PASSWD DATADIR IPADDR DOMAIN HOSTNAME
    docker-compose up --no-recreate -d

fi
