class vnc::service {
	service {
		"vncserver":
			require => Class["vnc::install"],
	}

	vnc::conf {
		"VNCSERVERS":
			ensure => "1:root",
	}
}
