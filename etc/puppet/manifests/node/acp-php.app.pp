node /^acp-php\d*\.app/ inherits default {
	php::conf {
		"PHP/max_input_vars":
			ensure => "10000",
	}

	php::ext {
		["gd"]:
	}

	include role_php_app_server, role_fastdfs_client
}
