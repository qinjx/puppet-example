node /^centos\d*\.vmtpl/ inherits default {
	puppet::client::conf {
		"main/server":
		ensure => "puppet-server.vip.$config::global::root_domain_name",
	}

	include role_centos_vmtpl, role_puppet_client
}
