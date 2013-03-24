#!/bin/sh
source ./shared_script.sh

#install packages
yum install -y puppet rsync

#read puppet server ip
echo "Please enter the ip address of [puppet-server.vip.$root_domain]
please enter it:"

read string

pps_ip="$string"
if [ -z $pps_ip ]
then
	echo "you have not entered the puppet server ip, exiting ..."
	exit
else
	sed -i -e '/$pps_hostname/d' /etc/hosts
	echo "$pps_ip $pps_hostname" >> /etc/hosts
fi

#read hostname
echo "Please enter the hostname (without $root_domain) for this machine
please enter it:"

read string

ppc_name="$string"
if [ -z $ppc_name ]
then
	echo "you have not entered the hostname, exiting ..."
	exit
else
	hostname=$ppc_name
fi

#set hostname
sed -i -e "s/HOSTNAME=.*/HOSTNAME=$ppc_hostname/" /etc/sysconfig/network

#run puppet client
rm /var/lib/puppet/{ssl,state} -rf
ssh $pps_hostname "puppet cert --clean $hostname.$root_domain $hostname.raw.$root_domain"
hostname "$hostname.raw.$root_domain"
puppetd --test --server $pps_hostname

rm /var/lib/puppet/{ssl,state} -rf
hostname "$hostname.$root_domain"
puppetd --test --server $pps_hostname

ssh $pps_hostname "puppet cert --clean $hostname.raw.$root_domain"