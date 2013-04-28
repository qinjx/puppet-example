node /^centos\d*\.vmtpl/ inherits default {
	file {
		"/etc/udev/rules.d/70-persistent-net.rules":
			ensure => absent,
	}
}
