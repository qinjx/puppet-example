class role_php_app_server {

	php::conf {
		"Date/date.timezone":
			ensure => "Asia/Chongqing";
		"PHP/display_errors":
			ensure => "On";
	}

	php::conf::fpm {
		"user":
			pool => "www",
			section => "www",
			ensure => "php";
		"group":
			pool => "www",
			section => "www",
			ensure => "php";
		"listen":
			pool => "www",
			section => "www",
			ensure => "0.0.0.0:9000";
		"listen.allowed_clients":
			pool => "www",
			section => "www",
			ensure => "${config::global::ip_prefix}.0/24";
	}

	user {
		"php":
			ensure => present,
	}

	php::ext {
		["mbstring", "mcrypt", "mysql", "pecl-apc"]:
	}

	yum::repo::conf {
		["remi"]:
	}

	include php::install, php::service
}
