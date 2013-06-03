class vnc::install {
	package {
		"tigervnc-server":
		    ensure => installed,
	}

	firewall::filter::allow {
		"5901":
	}

	file {
		"/root/.vnc/xstartup":
		    content => "
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc",
		    require => Package["tigervnc-server"],
	}

	vnc::server::conf {
		"VNCSERVERS" :
			ensure => "1:root",
	}

	yum::group::install {
		"KDE (K Desktop Environment)":
	}
}