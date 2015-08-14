#!/bin/sh

IPADDR=`ip add | grep " inet " | tail -n 1 |  ip -f inet -o addr show | tail -n 1 | cut -d\  -f 7 | cut -d/ -f 1`
HOSTNAME=`hostname`

echo $IPADDR $HOSTNAME >> /etc/hosts

