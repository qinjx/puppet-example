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
		"puppetmaster_8140":
			proto       => "tcp",
			dport       => "8140",
			jump        => "ACCEPT";
		"puppetmaster_8140_udp":
			proto       => "udp",
			dport       => "8140",
			jump        => "ACCEPT";
	}
}