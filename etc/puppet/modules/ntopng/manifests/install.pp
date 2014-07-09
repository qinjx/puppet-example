class ntopng::install {
	package {
		"ntopng":
			require => Yum::Repo::Conf["ntop"]
	}

	file {
		"/etc/ntopng":
			ensure => directory;
		"/etc/ntopng/ntopng.start":
			content => "--local-networks '$ipaddress/24'
--interface 1";
		"/etc/ntopng/ntopng.conf":
			content => "-G=/var/run/ntopng.pid";
		"/etc/cron.monthly/ntop-update-geodb":
			source => "puppet:///files/modules/ntopng/ntop-update-geodb";
	}

	exec {
		"download_geodb_for_ntopng":
			command => "/etc/cron.monthly/ntop-update-geodb",
			unless => "ls /usr/local/share/ntopng/httpdocs/geoip/",
			require => File["/etc/cron.monthly/ntop-update-geodb"],
	}

	firewall::filter::allow {
		"3000":
	}
}
