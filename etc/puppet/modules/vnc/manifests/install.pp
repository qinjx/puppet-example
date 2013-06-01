class vnc::install {
	package {
		"tigervnc-server":
		    ensure => installed,
	}

	firewall::filter::allow {
		"5901":
	}
}