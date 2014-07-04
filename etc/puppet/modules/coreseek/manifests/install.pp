class coreseek::install {
	package {
		"mysql-community-libs":
	}

	firewall::filter::allow {
		"9312":
	}

	file {
		"/root/coreseek_install.sh":
		    source => "puppet:///modules/coreseek/coreseek_install.sh",
	}

	exec {
		"/root/coreseek_install.sh":
		    require => File["/root/coreseek_install.sh"],
		    unless => "chkconfig | grep s 2>/dev/null",
	}
}
