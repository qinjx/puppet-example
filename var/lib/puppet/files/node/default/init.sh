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

        # set certname
		sed -i -e '/certname=/d' $(get_puppet_conf_dir)"/puppet.conf"
        sed -i '/\[main\]/ a\
        certname='$1 $(get_puppet_conf_dir)"/puppet.conf"

		echo your hostname has been set to ${host}
	else
		echo Internal error, empty parameter passed -_-
	fi
}

function set_ip() {
	# ip=`ping $1 -c 1 -w 1 | grep PING | awk -F "(" '{print \$2}' | awk -F ")" '{print \$1}'`
	local pattern="\s\+$1\.$root_domain"
	ip=`grep "${pattern}" /etc/hosts | awk '{print \$1}'`

	if [ `ip add | grep "$ip/" | grep -v grep | awk '{print $1}'` ]; then
		echo "ip address has been set to $ip"
	else
		echo "IP address will be: " $ip

		#set ip and restart
		sed -i -e "s/IPADDR=.*/IPADDR=$ip/" /etc/sysconfig/network-scripts/ifcfg-eth0
	fi

	echo "restarting network..."
	# restart eth0（如果etho的ONBOOT=no，用service network restart会导致eth0不自动启用，网络仍不可用）
	ifdown eth0
	ifup eth0

	if [ `ping ${puppet_server} -c 1 | grep from | awk '{print $1}'` ]; then
	    echo "network worked"
	else
	    echo "network not worked, exiting..."
	    exit
	fi
}

function rm_ca {
	rm_local_ca
	if [ -z $1 ]; then
		local hostname=`hostname`
		ssh ${puppet_server} "puppet cert --clean ${hostname}"
	else
		ssh ${puppet_server} "for host in $1 $1.raw; do if [ -f /var/lib/puppet/ssl/ca/signed/\$host.$root_domain.pem ]; then puppet cert clean \$host.$root_domain; fi; done"
	fi
}

function rm_local_ca {
	rm /var/lib/puppet/ssl/* -rf
}


function print_usage() {
	echo "Usage: init.sh task [hostname_without_root_domain], for example:
	init.sh init_vm test.sb
	init.sh set_hostname test.sb
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
		puppet agent -t

		rm_local_ca
		set_hostname $2
		puppet agent -t

		echo "Restarting? [y/N]"
		read str

        cfm_input="${str}"

        if [ ${cfm_input} == "y" ]; then
            reboot
        fi
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

	"set_hostname" )
		if [ -z $2 ]; then
			print_usage
			exit
		fi
		set_hostname $2
	;;

	* ) echo "task must be: init_vm, set_hostname, set_ip, rm_ca"
esac
