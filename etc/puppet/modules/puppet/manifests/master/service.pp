class puppet::master::service
{
	package
	{
		["puppet-server"]:
		ensure => installed,
		require => Yum::Repo::Conf["epel"],
	}

	service
	{
		"puppetmaster":
			ensure     => running,
			enable     => true,
			require    => Package["puppet-server"],
	}

	iptables
	{
		"tcp_8140_for_puppetmaster":
			proto       => "tcp",
			dport       => "8140",
			jump        => "ACCEPT";
		"udp_8140_forpuppetmaster":
			proto       => "udp",
			dport       => "8140",
			jump        => "ACCEPT";
	}
}