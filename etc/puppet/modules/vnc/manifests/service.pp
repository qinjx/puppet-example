class vnc::service {
	service {
		"vncserver":
			enable => true,
			ensure => running,
			require => Class["vnc::install"],
	}
}
