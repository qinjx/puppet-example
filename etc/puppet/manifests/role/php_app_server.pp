class role_php_app_server {
	php::conf {
		"Date/date.timezone":
			ensure => "Asia/Chongqing";
		"PHP/display_errors":
			ensure => "On";
	}

	php::ext {
		["mbstring", "mcrypt", "mysql", "pecl-apc"]:
	}

	php::conf::fpm {
		"listen.allowed_clients":
			pool => "www",
			section => "www",
			ensure => "127.0.0.1, ${config::global::ip_prefix}.${config::hosts::ip_list[lan1_lb]}, ${config::global::ip_prefix}.${config::hosts::ip_list[lan2_lb]}",
	}

	yum::repo::conf {
		["remi"]:
	}

	include php::install, php::service
}
