node /^sphinx\d*\.se/ inherits default {
	file {
		"/etc/sphinx/sphinx.conf":
			source => "puppet:///files/node/ppw.se/sphinx.conf";
		"/etc/sphinx":
			ensure => directory;
	}

	include role_search_engine
}
