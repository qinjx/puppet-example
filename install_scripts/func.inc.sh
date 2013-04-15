#!/bin/sh
function test_url() {
	local url=$1
	if curl --output /dev/null --silent --head --fail ${url}; then
		echo OK
	else
		echo FAILED
	fi
}

#@todo 支持puppet labs官方yum repo, 支持用户自己的本地yum镜像
function prepare_yum_repo() {
	local yum_mirror_prefix="http://mirrors.sohu.com/fedora-epel/"
	if [[ "OK" = $(test_url ${yum_mirror_prefix}) ]]; then
		echo "[epel]
name=CentOS-\$releasever - EPEL
baseurl=${yum_mirror_prefix}\$releasever/\$basearch/
enabled=1
gpgcheck=1
gpgkey=${yum_mirror_prefix}RPM-GPG-KEY-EPEL-\$releasever
" > /etc/yum.repos.d/epel.repo
		echo OK
	else
		echo FAILED
	fi
}

function get_user_input() {
	read string
	user_input="${string}"
	if [ -z ${user_input} ];then
		if [ ! -z $1 ]; then
			echo $1 #default value
		else
			echo FAILED
		fi
	else
		echo ${user_input}
	fi

}

function set_hostname() {
	if [ ! -z $1 ]; then
		hostname $1
		echo your hostname has been set to $1
	else
		echo Internal error, empty parameter passed -_-
	fi

}

default_private_root_domain="example.com"
function config_puppet_master() {
	echo "Please set your root domain for your private network,
	it can be a FAKE domain, suck as ${default_private_root_domain}

	Please enter it[${default_private_root_domain}]:"
	private_root_domain=$(get_user_input ${default_private_root_domain})
	set_hostname puppet-server.vip.${private_root_domain}
}

function config_puppet_client() {
	echo "Please set your root domain for your private network,
	it can be a FAKE domain, suck as ${default_private_root_domain}

	Please enter it[${default_private_root_domain}]:"
	private_root_domain=$(get_user_input ${default_private_root_domain})
	set_hostname puppet-client.${private_root_domain}

	#获取puppet server的ip，并加入hosts
	echo "Please enter the ip address of [puppet-server.vip.${private_root_domain}]"
	pps_ip=$(get_user_input)
	if [ -z $pps_ip ]; then
		echo "you have not entered the puppet server ip, exiting ..."
		exit
	else
		pps_hostname=puppet-server.vip.${private_root_domain}
		sed -i -e '/$pps_hostname/d' /etc/hosts
		echo "$pps_ip $pps_hostname" >> /etc/hosts
	fi
fi
}

########## Entrance function ##########
# The entrance function should be placed at the end of this file
# because shell is parsed and executed line by line

#@todo 通过网络校准puppet server的时间
function install_master() {
	echo Installing puppet master
	yum install -y puppet-server
	config_puppet_master
}

#@todo 通过网络校准puppet client的时间
function install_client() {
	echo Installing puppet client
	yum install -y puppet
	config_puppet_client
}
########## Entrance function ##########