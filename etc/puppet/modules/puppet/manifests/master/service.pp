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

	firewall::filter::allow {
		"8140":
			proto => "tcp";
		"udp_8140":
			proto => "udp",
			dport => "8140";
	}
}