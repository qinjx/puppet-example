class coreseek::install {
	package {
		"mysql-community-libs":
	}

	firewall::filter::allow {
		"9312":
	}

	file {
		"/etc/init.d/searchd":
			source => "puppet:///modules/coreseek/searchd",
	}

	exec {
		"coreseek_install":
		    command => "rsync -rp /opt/coreseek/* /"
		    unless => "ls /usr/bin/searchd 2>/dev/null",
	}
}
