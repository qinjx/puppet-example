class vnc::install {
	package {
		"tigervnc-server":
	}

	firewall::filter::allow {
		"5901":
	}

	yum::group::install {
		["X Window System", "Desktop", "Chinese Support"]:
	}
}
