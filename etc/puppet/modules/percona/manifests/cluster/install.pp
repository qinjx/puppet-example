class percona::cluster::install {
	augeas {
		"disable_selinux":
			lens => "Shellvars.lns",
			incl => "/etc/selinux/config",
			changes => "set SELINUX disabled",
	}

	exec {
		"disable_selinux_now_for_percona_cluster":
			command => "/usr/sbin/setenforce 0",
	}

	package {
		"mysql-libs-5.1.66":
			ensure => absent;
		["Percona-XtraDB-Cluster-server", "Percona-XtraDB-Cluster-client"]:
			ensure => installed,
			require => [Yum::Repo::Conf["percona"], Package["mysql-libs-5.1.66"]];
	}

	firewall::filter::allow {
		["3306", "4444", "4567", "4568"]:
	}
}