#!/bin/sh
############################## function start ##############################
function test_url() {
	local url=$1
	if curl --output /dev/null --silent --head --fail ${url}; then
		echo OK
	else
		echo FAILED
	fi
}

function sync_package() {
	local repo_server_url=$1
	if [[ "OK" = $(test_url $1) ]]; then
		wget -N -r -l 2 "${repo_server_url}/x86_64"
		rm -rf "${repo_server_url}/x86_64/repodata"
		wget -N -r -l 2 "${repo_server_url}/x86_64/repodata"
	fi
}

function download_gpg_key() {
	local gpg_key_url=$1 #without http://
	if [ ! -f ${gpg_key_url} ]; then
		curl "http://${gpg_key_url}" -o ${gpg_key_url}
	fi
}


############################## function end ##############################
yum_mirror_root="/opt/yum_mirror" #@todo to be configured by puppet
if [ ! -d ${yum_mirror_root} ]; then
	mkdir -p ${yum_mirror_root}
fi
cd ${yum_mirror_root}

#sync rpms
for url in http://mirrors.sohu.com/centos/6.4/extras\
http://mirrors.sohu.com/centos/6.4/os\
http://mirrors.sohu.com/centos/6.4/updates\
http://mirrors.sohu.com/fedora-epel/6\
http://rpms.famillecollet.com/enterprise/6/remi\
http://repo.percona.com/centos/6/os\
http://poptop.sourceforge.net/yum/beta/rhel6
do
	sync_package $url
done

#dir for percona gpg_key
if [ ! -d www.percona.com/downloads/percona-release ]; then
	mkdir -p www.percona.com/downloads/percona-release
fi

#download gpg keys
for file in mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-6\
rpms.famillecollet.com/RPM-GPG-KEY-remi\
www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona\
poptop.sourceforge.net/yum/RPM-GPG-KEY-PPTP
do
	download_gpg_key $file
done

#make a symbol link for centos6
ln -s mirrors.sohu.com/centos/6.4 mirrors.sohu.com/centos/6