node /^centos\d*\.vmtpl/ inherits default {
	puppet::client::conf {
		"main/server":
		ensure => "puppet-server.vip.$config::global::root_domain_name",
	}

	ntp::conf {
		"server":
		ensure => "puppet-server.vip",
	}

	include role_centos_vmtpl, role_puppet_client, role_ntp_client
}
