#!/bin/bash

REALM=example

DS_PASSWD=abcd1234
ADMIN_PASSWD=abcd1234
DATADIR=/var/lib/ipa-data
IPADDR=10.130.1.250

DOMAIN=${REALM}.com
HOSTNAME=ipa.${DOMAIN}



if [ ! -d "$DATADIR" ]; then
   sudo mkdir $DATADIR
fi

           #-p 53:53/udp -p 53:53 \
           #-p 123:123/udp \
           #--tmpfs /run --tmpfs /tmp \
           #-e IPA_SERVER_IP=$IPADDR \

docker run --name freeipa-server-container -ti --rm \
           --privileged \
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


