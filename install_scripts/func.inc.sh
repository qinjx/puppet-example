#!/bin/sh
function test_url() {
	local url=$1
	if curl --output /dev/null --silent --head --fail ${url}; then
		echo OK
	else
		echo FAILED
	fi
}

function prepare_puppet_yum_repo() {
	local puppetlabs_repo_rpm="https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"
	if [[ "OK" = $(test_url ${puppetlabs_repo_rpm}) ]]; then

        rpm -Uvh puppetlabs_repo_rpm
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
		sed -i -e "s/HOSTNAME=.*/HOSTNAME=$1/" /etc/sysconfig/network
		echo your hostname has been set to $1
	else
		echo Internal error, empty parameter passed -_-
	fi

}

function get_default_private_root_domain() {
	echo example.com
}

function get_puppet_conf_dir() {
	echo "/etc/puppet"
}

function adj_time_by_ntp() {
	yum install -y ntpdate
	ntpdate 0.asia.pool.ntp.org
}

function config_puppet_master() {
	adj_time_by_ntp

	default_private_root_domain=$(get_default_private_root_domain)
	echo "Please set your root domain for your private network,
	it can be a FAKE domain, suck as ${default_private_root_domain}

	Please enter it[${default_private_root_domain}]:"
	
	private_root_domain=$(get_user_input ${default_private_root_domain})
	
	#set hostname
	set_hostname puppet-server.vip.${private_root_domain}
	echo "The hostname of your puppet server is:"
	hostname

	#autosign
	echo "*.${private_root_domain}" > $(get_puppet_conf_dir)"/autosign.conf"

	#file bucket
	sed -i -e "s/\# \[files\]/\[files\]/g" $(get_puppet_conf_dir)"/fileserver.conf"
	sed -i -e "s/\#  path/path/g" $(get_puppet_conf_dir)"/fileserver.conf"
	sed -i -e "s/\#  allow \*\.example\.com/allow \*\.${private_root_domain}/g" $(get_puppet_conf_dir)"/fileserver.conf"
	mkdir /var/lib/puppet/files
	chown puppet:puppet /var/lib/puppet/files
	chmod 750 /var/lib/puppet/files

	#enable puppetmaster
	chkconfig puppetmaster on

	#enable 8140 port
	sed -i "/\-\-dport 8140/d" /etc/sysconfig/iptables
	sed -i '/dport 22/ a\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 8140 \-j ACCEPT' /etc/sysconfig/iptables
	sed -i '/dport 22/ a\-A INPUT \-m state \-\-state NEW \-m udp \-p udp \-\-dport 8140 \-j ACCEPT' /etc/sysconfig/iptables
	service iptables restart
}

function config_puppet_client() {

	default_private_root_domain=$(get_default_private_root_domain)
	echo "Please set your root domain for your private network,
	it can be a FAKE domain, suck as ${default_private_root_domain}

	Please enter it[${default_private_root_domain}]:"
	
	private_root_domain=$(get_user_input ${default_private_root_domain})
	set_hostname puppet-client.${private_root_domain}

	#add puppet server into /etc/hosts
	echo "Please enter the ip address of [puppet-server.vip.${private_root_domain}]"
	pps_ip=$(get_user_input)
	if [ -z $pps_ip ]; then
		echo "you have not entered the puppet server ip, exiting ..."
		exit
	else
		pps_hostname=puppet-server.vip.${private_root_domain}
		sed -i -e '/${pps_hostname}/d' /etc/hosts
		echo "${pps_ip} ${pps_hostname}" >> /etc/hosts
	fi

	adj_time_by_ntp
    
    sed -i '/\[main\]/ a\
    server='${pps_hostname} $(get_puppet_conf_dir)"/puppet.conf"

	chkconfig puppet on

	#how to run puppet client
	echo "Please run:

	puppetd -t

	"
}

########## Entrance function ######
# The entrance function should be p
# because shell is parsed and execu

function install_master() {
	if [[ "OK" = $(prepare_puppet_yum_repo $1) ]]; then
		echo Installing puppet master
		yum install -y puppet-server
		config_puppet_master
	else
		echo yum mirror can\'t be connected
	fi
}

function install_client() {
	if [[ "OK" = $(prepare_puppet_yum_repo $1) ]]; then
		echo Installing puppet client
		yum install -y puppet
		config_puppet_client
	else
		echo yum mirror can\'t be connected
	fi
}
########## Entrance function ##########
