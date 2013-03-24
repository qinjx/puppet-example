#!/bin/sh
source ./shared_script.sh

#install packages
yum install -y puppet puppet-server cronie rsync subversion

#set hostname
sed -i -e "s/HOSTNAME=.*/HOSTNAME=$pps_hostname/" /etc/sysconfig/network

#start puppermaster
service puppetmaster start

#copy pp files
sh set_domain.sh $root_domain

if [ $dev_mode == 0 ]
then
	rsync -rp ../etc/puppet/* /etc/puppet/
	sh set_domain.sh $root_domain

else #developer will checkout source from svn
	rm -rf /etc/puppet/manifests
	svn checkout https://puppet-example.googlecode.com/svn/trunk/etc/puppet /etc/puppet
	sh set_domain.sh $root_domain

	sed -i -e "s/^\$use_local_yum_mirror *= *.*/\$use_local_yum_mirror = 1/" /etc/puppet/manifests/config.pp
	hostname "puppet-server.vip.raw.$root_domain"
	puppet apply /etc/puppet/manifests/site.pp
	hostname $pps_hostname
	puppet apply /etc/puppet/manifests/site.pp
fi

service puppetmaster restart

echo "Congratulations!

The puppet server has been installed succesfully
current system yum repos have been backuped to $repo_bak_dir

the puppet server's hostname is: "
hostname