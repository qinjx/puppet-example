class vnc::service {
	service {
		"vncserver":
			require => Class["vnc::install"],
	}
}
