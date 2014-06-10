class role_php_app_server {
	php::conf {
		"Date/date.timezone":
			ensure => "Asia/Chongqing";
		"PHP/display_errors":
			ensure => "On";
	}

	php::ext {
		["bcmath", "gd", "mbstring", "mcrypt", "mysql", "mysqlnd", "pecl-apc", "pecl-memcached", "redis", "soap"]:
	}

	php::conf::fpm {
		"listen.allowed_clients":
			pool => "www",
			section => "www",
			ensure => "127.0.0.1,${config::global::ip_prefix}.${config::hosts::ip_list[lan1_lb]},${config::global::ip_prefix}.${config::hosts::ip_list[lan2_lb]}";
		"catch_workers_output":
			pool => "www",
			section => "www",
			ensure => "yes";
	}

	yum::repo::conf {
		["epel", "remi"]:
	}

	include php::install, php::service
}
