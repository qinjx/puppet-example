define php::conf($ensure) {
	augeas {
		"change_php_setting_${name}":
			context => "/files/etc/php.ini",
			changes => "set ${name} ${ensure}",
			require => Package["php-fpm"],
			notify => Service["php-fpm"],
	}
}

