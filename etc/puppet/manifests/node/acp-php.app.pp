node /^acp-php\d*\.app/ inherits default {
	php::conf {
		"PHP/max_input_vars":
			ensure => "10000",
	}

	php::ext {
		["exif"]:
		    ensure => installed,
	}

	php::fpm::conf {
		"listen":
			pool => "www",
			section => "www",
			ensure => "0.0.0.0:9001",
	}

	include role_php_app_server
}