node /^tool\d*\.web/ inherits default {
	nginx::conf::vhost {
		"www.$config::web::public_domain_name":
			www_root => "/var/www",
			fcgi_conf => "php",
	}

	nginx::conf::location {
		"php":
			pattern => "\\.php\$",
			fcgi_address => "${ipaddress}:9000",
	}
	include role_web_server, role_php_app_server
}