class ssh::server::service {
	service {
		"sshd":
		    require => Class["ssh::server::install"],
	}
}
