class keepalived::install {
	package {
		"keepalived":
			require => Yum::Repo::Conf["epel"],
	}

	file {
		"/etc/keepalived/conf.d":
			ensure => directory,
			require => Package["keepalived"];
		"/etc/keepalived/keepalived.conf":
			require => Package["keepalived"],
			content => "global_defs {
   notification_email {
		acassen@firewall.loc
 		failover@firewall.loc
 		sysadmin@firewall.loc
 	}
	notification_email_from Alexandre.Cassen@firewall.loc
	smtp_server 192.168.200.1
	smtp_connect_timeout 30
	router_id LVS_DEVEL
}

include /etc/keepalived/conf.d/*.conf";
	}

	iptables {
		"multicast":
			destination => "224.0.0.0/8",
			jump        => "ACCEPT";

		"vrrp_input":
			proto       => "vrrp",
			chain       => "INPUT",
			jump        => "ACCEPT";

		"vrrp_output":
			proto       => "vrrp",
			chain       => "OUTPUT",
			jump        => "ACCEPT";
	}
}
