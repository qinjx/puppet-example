node /^shop\d*\.se/ inherits default {
	file {
		"/etc/sphinx/sphinx.conf":
			source => "puppet:///files/node/shop.se/sphinx.conf";
		"/etc/sphinx":
			ensure => directory;
	}

	include role_search_engine
}
