#!/bin/sh
#load config
. ./conf.ini

########################### functions start ###########################
function user_confirm() {
	local rand_string=`date | md5sum`
	local secret=${rand_string:8:3}
	
	echo "---------- WARNING ----------
	
	This is an initial script O-N-L-Y for new barebone, it will erase your config and data.
	
	Please repeat the following random number for comfirmation
	the random number is : 
	
			${secret}
	
	please enter it: "
	read string
	
	local confirm_input="${string}"
	
	if [ ${confirm_input} != ${secret} ]
	then
		echo "The random number you entered does not match, exiting..."
		exit
	fi
}

function set_hostname() {
	if [ ! -z $1 ]; then
		local host="$1.$root_domain"
		hostname ${host}
		sed -i -e "s/HOSTNAME=.*/HOSTNAME=$host/" /etc/sysconfig/network
		echo your hostname has been set to ${host}
	else
		echo Internal error, empty parameter passed -_-
	fi

}

function set_ip() {
	# ip=`ping $1 -c 1 -w 1 | grep PING | awk -F "(" '{print \$2}' | awk -F ")" '{print \$1}'`
	local pattern="\s\+$1\.$root_domain"
	ip=`grep "${pattern}" /etc/hosts | awk '{print \$1}'`

	if [ `ip add | grep "$ip" | grep -v grep | awk '{print $1}'` ]; then
		echo "ip address has been set to $ip"
	else
		echo "IP address will be: " $ip

		#set ip and restart
		sed -i -e "s/IPADDR=.*/IPADDR=$ip/" /etc/sysconfig/network-scripts/ifcfg-eth0

		echo "restarting network..."
		# restart eth0（如果etho的ONBOOT=no，用service network restart会导致eth0不自动启用，网络仍不可用）
		ifdown eth0
		ifup eth0
	fi
}

function rm_ca {
	rm /var/lib/puppet/ssl/* -rf
	if [ -z $1 ]; then
		local hostname=`hostname`
		ssh ${puppet_server} "puppet cert --clean ${hostname}"
	else
		ssh ${puppet_server} "for host in $1 $1.raw; do if [ -f /var/lib/puppet/ssl/ca/signed/\$host.$root_domain.pem ]; then puppet cert clean \$host.$root_domain; fi; done"
	fi
}

function print_usage() {
	echo "Usage: init.sh task [hostname_without_root_domain], for example:
	init.sh init_vm test.sb
	init.sh set_ip test.sb
	init.sh rm_ca test.sb
	init.sh rm_ca"
}
########################### functions end ###########################

########################### Entrance ###########################
if [ -z $1 ]; then
	print_usage
	exit
fi

case $1 in
	"init_vm" )
		if [ -z $2 ]; then
			print_usage
			exit
		fi
		user_confirm
		set_ip $2

		rm_ca $2
		set_hostname "$2.raw"
		puppetd -t

		rm_ca $2
		set_hostname $2
		puppetd -t
	;;

	"set_ip" )
		if [ -z $2 ]; then
			print_usage
			exit
		fi
		set_ip $2
	;;

	"rm_ca" )
		if [ -z $2 ]; then
			rm_ca
		else
			rm_ca $2
		fi
	;;

	* ) echo "task must be: init_vm, set_ip, rm_ca"
esac
