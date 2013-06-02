class ssh::server::service {
	service {
		"sshd":
			ensure => running,
			enable => true,
	}
}
