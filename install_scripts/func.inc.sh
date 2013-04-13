#!/bin/bash
function test_url() {
	local url=$1
	if curl --output /dev/null --silent --head --fail ${url}; then
		echo OK
	else
		echo FAILED
	fi
}

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

function install_master(){
	echo install master
	yum install -y puppet-server
}

function install_client() {
	echo client
	yum install -y puppet
}