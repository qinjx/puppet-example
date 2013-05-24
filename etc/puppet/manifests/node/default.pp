node default {
	file {
		"/root/init_scripts/":
			ensure => directory;

		"/root/init_scripts/conf.ini":
			ensure => present,
			require => File["/root/init_scripts/"];
		
		"/root/init_scripts/init.sh":
			ensure => present,
			source => "puppet:///files/node/default/init.sh",
			require => File["/root/init_scripts/conf.ini"];
		
		"/etc/puppet/iptables":
			ensure => directory;

		"/etc/puppet/iptables/pre.iptables":
			content => "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT",
			mode    => 0600;

		"/etc/puppet/iptables/post.iptables":
			content => "-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited",
			mode    => 0600;
	}

	iptables {
		"tcp_22_for_sshd":
			proto       => "tcp",
			dport       => "22",
			jump        => "ACCEPT",
	}

	augeas {
		"init_vm_config_ini":
			lens => "Shellvars.lns",
			incl => "/root/init_scripts/conf.ini",
			changes => [
				"set puppet_server $config::global::host_puppet_server",
				"set root_domain $config::global::root_domain_name"
			],
			require => File["/root/init_scripts/conf.ini"],
	}

	yum::repo::conf {
		["centos_base", "centos_updates", "centos_extras"]:
	}


	hosts::conf {
		$config::hosts::ip_keys:
	}

	include role_puppet_client
}
