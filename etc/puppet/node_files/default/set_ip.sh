#!/bin/sh
# get ip addr from /etc/hosts(or from dns server)
# ip=`ping $1 -c 1 -w 1 | grep PING | awk -F "(" '{print \$2}' | awk -F ")" '{print \$1}'`
ip=`grep $1 /etc/hosts | awk '{print \$1}'`
echo "IP address will be: " $ip

#set ip and restart network
sed -i -e "s/IPADDR=.*/IPADDR=$ip/" /etc/sysconfig/network-scripts/ifcfg-eth0

echo "restarting network..."
# restart network
service network restart