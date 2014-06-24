node /^acp-php\d*\.app/ inherits default {
	php::conf {
		"PHP/max_input_vars":
			ensure => "10000",
	}

	php::ext {
		["gd"]:
	}

	php::conf {
		"Date/date.timezone":
		ensure => "Asia/Chongqing";
		"PHP/display_errors":
		ensure => "On";
	}

	php::ext {
		["bcmath", "gd", "mbstring", "mcrypt", "mysql", "pecl-apc", "pecl-imagick", "pecl-memcache", "pecl-memcached",
		"pecl-mongo", "pecl-redis", "soap"]:
		notify => Service["php-fpm"],
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
		"request_slowlog_timeout":
		pool => "www",
		section => "www",
		ensure => 1;
	}

	yum::repo::conf {
		["remi"]:
	}

	include php::install, php::service
	include fastdfs::client::install
}
