#!/bin/sh
if [ -z $1 ]
then
	tun_name="default"
else
	tun_name="$1"
fi

# check if tunnel config exists
if [ ! -f /etc/ppp/peers/$tun_name ]
then
	echo "Can not find config file of tunnel [$tun_name], please run pptpsetup to create it first:
	
pptpsetup --delete $tun_name 
pptpsetup --create $tun_name --server xx.xx.xx.xx --username xxxx --password **** 
"
	exit
fi

#check if ppp0 exists
if [ `ip add | grep ppp0: | awk '{print $1}'` ]
then
	echo "ppp0 exists, skipping"
else
	pppd call $tun_name logfd 2 nodetach debug dump refuse-eap require-mppe persist
	#pppd call $tun_name logfd 2 nodetach debug dump nomppe-128 persist
fi
route add -net 0.0.0.0 dev ppp0

#check if keepalived running
if [ `service keepalived status | awk '{print $1}'` ]
then
	echo "keepalived is running, skipping"
else
	service keepalived start
fi
