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
		["centos_base", "centos_updates", "centos_extras", "epel"]:
	}

	firewall::filter::allow {
		"22":
	}

	hosts::conf {
		$config::hosts::ip_keys:
	}

	include role_puppet_client
}
