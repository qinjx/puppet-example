class percona_service
{
	augeas
	{
		"disable_selinux":
			lens => "Shellvars.lns",
			incl => "/etc/selinux/config",
			changes => [
				"set SELINUX disabled"
			],
	}

	package
	{
		["Percona-XtraDB-Cluster-server", "Percona-XtraDB-Cluster-client"]:
			ensure => present,
			require => Yumrepo["percona"]
	}
	
	iptables
	{
		"percona_mysql_3306":
			proto       => "tcp",
			dport       => "3306",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"percona_wsrep_4444":
			proto       => "tcp",
			dport       => "4444",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"percona_wsrep_4567":
			proto       => "tcp",
			dport       => "4567",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"percona_wsrep_4568":
			proto       => "tcp",
			dport       => "4568",
			jump        => "ACCEPT",
	}
}

