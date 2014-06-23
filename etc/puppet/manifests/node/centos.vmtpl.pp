node /^centos\d*\.vmtpl/ inherits default {
	puppet::client::conf {
		"main/server":
		ensure => "puppet-server.vip.$config::global::root_domain_name",
	}

	ntp::conf {
		"server":
		ensure => "puppet-server.vip",
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

	include role_centos_vmtpl, role_puppet_client, role_ntp_client
}
