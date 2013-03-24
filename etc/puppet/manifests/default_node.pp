node default {
	include ssh
	include yum
	include system
	
	puppet_client::puppet::conf
	{
		"agent/server":
			ensure => "$host_puppet_server";
		"agent/runinterval":
			ensure => 300;
		"agent/show_diff":
			ensure => "true";
		"agent/pluginsync":
			ensure => "true";
	}

	file
	{
		"/root/config.ini":
			ensure => present,
	}
	
	file
	{
		"/root/init_vm.sh":
			mode => 755,
			source => "puppet:///node_files/default/init_vm.sh",
	}
	
	file
	{
		"/root/set_ip.sh":
			mode => 755,
			source => "puppet:///node_files/default/set_ip.sh",
	}
	
	file
	{
		"/root/rm_ca.sh":
			mode => 755,
			source => "puppet:///node_files/default/rm_ca.sh",
	}
	
	augeas
	{
		"init_vm_config_ini":
			lens => "Shellvars.lns",
			incl => "/root/config.ini",
			changes => [
				"set puppet_server $host_puppet_server",
				"set root_domain $root_domain_name"
			],
			require => File["/root/config.ini"],
	}

	package
	{
		"xe-guest-utilities-xenstore":
			ensure => present,
			provider => "rpm",
			source => "${url_yum_mirror_prefix}rpm_beyond_yum/xe-guest-utilities-xenstore-1.4.90-747.x86_64.rpm",
	}

	package
	{
		"xe-guest-utilities":
			ensure => present,
			provider => "rpm",
			require => Package["xe-guest-utilities-xenstore"],
			source => "${url_yum_mirror_prefix}rpm_beyond_yum/xe-guest-utilities-1.4.90-747.x86_64.rpm",
	}

	import "default_node_hosts.pp"
}
