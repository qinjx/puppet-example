#!/bin/sh
# entering developer mode, by passing the local yum mirror url prefix as the first parameter
# the developer has local fast yum mirror :)
local_yum_mirror_prefix="$1"
if [ -z $local_yum_mirror_prefix ]
then
	yum_mirror_prefix="mirrors.sohu.com"
	dev_mode=0
else
	yum_mirror_prefix=$local_yum_mirror_prefix
	echo $yum_mirror_prefix
	dev_mode=1
fi
#default setting
default_conf_root_domain="example.com"

#checking yum mirror site
echo "checking yum mirror site ..."
yum_mirror_prefix_check_url="http://$yum_mirror_prefix/fedora-epel/"
if [ `curl -I $yum_mirror_prefix_check_url | grep '200 OK' | awk '{print $1}'` ]
then
	echo "[OK]"
else
	echo "[FAILED], please make sure $yum_mirror_prefix_check_url can be accessed on the mirror site"
	exit
fi

#replace yum repo
repo_bak_dir=`pwd`"/yum_repo_bak"
mkdir $repo_bak_dir
mv /etc/yum.repos.d/* $repo_bak_dir

echo "[centos_base]
baseurl=http://$yum_mirror_prefix/centos/\$releasever/os/\$basearch/
gpgcheck=1
gpgkey=http://$yum_mirror_prefix/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever
name=CentOS-\$releasever - Base

[centos_extras]
baseurl=http://$yum_mirror_prefix/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://$yum_mirror_prefix/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever
name=CentOS-\$releasever - Extras

[centos_updates]
baseurl=http://$yum_mirror_prefix/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://$yum_mirror_prefix/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever
name=CentOS-\$releasever - Updates

[epel]
name=CentOS-\$releasever - EPEL
baseurl=http://$yum_mirror_prefix/fedora-epel/\$releasever/\$basearch/
enabled=1
gpgcheck=1
gpgkey=http://$yum_mirror_prefix/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever
" > /etc/yum.repos.d/epel.repo

#read root domain
echo "Please set your root domain for your private network, if can be a FAKE domain, suck as example.com
please enter it:[$default_conf_root_domain]"

read string

user_root_domain="$string"
if [ -z $user_root_domain ]
then
	root_domain=$default_conf_root_domain
else
	root_domain=$user_root_domain
fi

pps_hostname="puppet-server.vip.$root_domain"