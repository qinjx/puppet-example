node /^shop\d*\.se/ inherits default {
	file {
		"/etc/sphinx/sphinx.conf":
		require => Package["sphinx"],
		source => "puppet:///files/node/shop.se/sphinx.conf",
	}

	include role_search_engine
}
