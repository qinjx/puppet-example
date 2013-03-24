node /^centos\d*\.vmtpl/ inherits default {
	include yum

	file
	{
		"/etc/udev/rules.d/70-persistent-cd.rules":
			ensure => absent,
	}

	import "default_node_hosts.pp"
}
