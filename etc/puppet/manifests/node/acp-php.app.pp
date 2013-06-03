node /^acp-php\d*\.app/ inherits default {
	php::conf {
		"PHP/max_input_vars":
			ensure => "10000",
	}

	php::ext {
		["gd"]:
		    ensure => installed,
	}

	include role_php_app_server
}