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

	yum::repo::conf {
		["remi", "epel"]:
	}

	include php::install, php::service
}
