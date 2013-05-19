class percona::cluster::install {
	augeas
	{
		"disable_selinux":
		lens => "Shellvars.lns",
		incl => "/etc/selinux/config",
		changes => "set SELINUX disabled",
	}

	exec
	{
		"disable_selinux_now_for_percona_cluster":
		command => "/usr/sbin/setenforce 0",
	}

	package
	{
		"mysql-libs-5.1.66":
		ensure => absent;
		["Percona-XtraDB-Cluster-server", "Percona-XtraDB-Cluster-client"]:
		ensure => installed,
		require => [Yum::Repo::Conf["percona"], Package["mysql-libs-5.1.66"]];
	}

	iptables
	{
		"tcp_3306_for_percona_cluster":
		proto       => "tcp",
		dport       => "3306",
		jump        => "ACCEPT";
		"tcp_4444_for_percona_cluster":
		proto       => "tcp",
		dport       => "4444",
		jump        => "ACCEPT";
		"tcp_4567_for_percona_cluster":
		proto       => "tcp",
		dport       => "4567",
		jump        => "ACCEPT";
		"tcp_4568_for_percona_cluster":
		proto       => "tcp",
		dport       => "4568",
		jump        => "ACCEPT";
	}
}