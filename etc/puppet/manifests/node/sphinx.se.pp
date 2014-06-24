node /^sphinx\d*\.se/ inherits default {
	file {
		"/etc/sphinx/sphinx.conf":
			source => "puppet:///files/node/ppw.se/sphinx.conf";
		"/etc/sphinx":
			ensure => directory;
	}

	firewall::filter::allow {
    	"9315":
	}

	yum::repo::conf {
		"mysql":
	}

	include sphinx::install, sphinx::service
}
