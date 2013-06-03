class vnc::install {
	package {
		"tigervnc-server":
		    ensure => installed,
	}

	firewall::filter::allow {
		"5901":
	}

	file {
		"/root/.vnc":
			ensure => directory;
		"/root/.vnc/xstartup":
			content => "
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc",
			require => File["/root/.vnc"];
	}

	vnc::conf {
		"VNCSERVERS":
			ensure => "1:root",
	}

	yum::group::install {
		["X Window System", "KDE (K Desktop Environment)"]:
	}
}
