#!/bin/sh
. /root/config.ini

########## warning and comfirming start ##########
rand_string=`date | md5sum`
secret=${rand_string:8:3}

echo "---------- WARNING ----------

This is an initial script O-N-L-Y for new barebone, it will erase your config and data.

Please repeat the following random number for comfirmation
the random number is : 

        $secret

please enter it: "
read string

comfirm_input="$string"

if [ $comfirm_input != $secret ]
then
	echo "The random number you entered does not match, exiting..."
	exit
fi
##########  warning and comfirming end  ##########
. ./set_ip.sh

# just killing the time, to make sure the fucking puppetd can run successfully -_-
ping $puppet_server -c 3

############## initial puppet
. ./rm_ca.sh

hostname $hostname_raw
puppetd --test --server $puppet_server

# write puppet alias into bashrc
if [ ! `grep pp /root/.bashrc | awk '{print $1}'` ]
then
	echo "alias pp='puppetd --test --server $puppet_server'" >> /root/.bashrc
fi
source /root/.bashrc

# remove cert on puppet-server
echo "all jobs done, remove cert of $hostname_raw on puppet server and then clean you /var/lib/puppet/"
. ./rm_ca.sh


# set HOSTNAME
echo "set hostname to $hostname"
hostname $hostname
sed -i -e "s/HOSTNAME=.*/HOSTNAME=$hostname/" /etc/sysconfig/network

echo "run hostname to comfirm:"
hostname
