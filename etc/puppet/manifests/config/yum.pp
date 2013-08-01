class config::yum {
	$use_local_yum_mirror = true
	$local_yum_mirror_prefix = "yum-mirror.sys.vip"

	$urls = {
		centos_base => "mirrors.sohu.com/centos/\$releasever/os/\$basearch/",
		centos_updates => "mirrors.sohu.com/centos/\$releasever/updates/\$basearch/",
		centos_extras => "mirrors.sohu.com/centos/\$releasever/extras/\$basearch/",
		epel => "mirrors.sohu.com/fedora-epel/\$releasever/\$basearch/",
		remi => "rpms.famillecollet.com/enterprise/\$releasever/remi/\$basearch/",
		percona => "repo.percona.com/centos/\$releasever/os/\$basearch/",
		pptp => "poptop.sourceforge.net/yum/beta/rhel\$releasever/\$basearch/",
		nginx => "nginx.org/packages/centos/\$releasever/\$basearch/",
		hop5 => "www.hop5.in/yum/el\$releasever/"
	}

	$keys = {
		centos_base => "mirrors.sohu.com/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
		centos_updates => "mirrors.sohu.com/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
		centos_extras => "mirrors.sohu.com/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
		epel => "mirrors.sohu.com/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever",
		remi => "rpms.famillecollet.com/RPM-GPG-KEY-remi",
		percona => "www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona",
		pptp => "poptop.sourceforge.net/yum/RPM-GPG-KEY-PPTP",
		nginx => "nginx.org/packages/keys/nginx_signing.key",
		hop5 => nil
	}
}
