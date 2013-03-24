class role_yum_mirror
{	
	package
	{
		["wget"]:
			ensure => present,
	}

	file
	{
		$yum_mirror_www_root:
			ensure => directory,
	}

	file
	{
		"/opt/sync_yum_mirror.sh":
			mode => 755,
			content => "#!/bin/sh
cd $yum_mirror_www_root

#centos 6
wget -N -r -l 2 http://mirrors.sohu.com/centos/6.2/extras/x86_64/
wget -N -r -l 2 http://mirrors.sohu.com/centos/6.2/os/x86_64/
wget -N -r -l 2 http://mirrors.sohu.com/centos/6.2/updates/x86_64/
#centos 5 for xcp1.5
wget -N -r -l 2 http://mirrors.sohu.com/centos/5/extras/x86_64/
wget -N -r -l 2 http://mirrors.sohu.com/centos/5/os/x86_64/
wget -N -r -l 2 http://mirrors.sohu.com/centos/5/updates/x86_64/

#epel
wget -R repoview -N -r -l 2 http://mirrors.sohu.com/fedora-epel/6/x86_64/
curl http://mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-6 -o mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-6

#centos 5 for xcp1.5
wget -R repoview -N -r -l 2 http://mirrors.sohu.com/fedora-epel/5/x86_64/
curl http://mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-5 -o mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-5

#remi
wget -N -r -l 2 http://rpms.famillecollet.com/enterprise/6/remi/x86_64/
curl http://rpms.famillecollet.com/RPM-GPG-KEY-remi rpms.famillecollet.com/RPM-GPG-KEY-remi

#percona
wget -N -r -l 2 http://repo.percona.com/centos/6/os/x86_64/
mkdir -p www.percona.com/downloads/percona-release
curl http://www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona -o www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona

#pptp
wget -N -r -l 2 http://poptop.sourceforge.net/yum/beta/rhel6/x86_64/
curl http://poptop.sourceforge.net/yum/RPM-GPG-KEY-PPTP -o poptop.sourceforge.net/yum/RPM-GPG-KEY-PPTP
#the end",
	}

	cron
	{
		"cron_sync_yum_mirror":
			command => "/opt/sync_yum_mirror.sh",
			user => root,
			hour => 3,
			require => Package["cronie"],
	}
}
