class ssh::server::service {
	service {
		"sshd":
			require => Class["ssh::server::install"],
	}

	ssh::server::conf {
		"ListenAddress":
			ensure => "0.0.0.0",
	}
}
