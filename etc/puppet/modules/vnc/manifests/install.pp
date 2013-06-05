class vnc::install {
	package {
		"tigervnc-server":
	}

	firewall::filter::allow {
		"5901":
	}

	vnc::conf {
		"VNCSERVERS":
			ensure => "1:root",
	}

	yum::group::install {
		["X Window System", "Desktop", "Chinese Support"]:
	}
}
