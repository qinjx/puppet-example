define php::conf($ensure, $conf_file=nil) {
	if ($conf_file==nil) {
		$file = "php.ini"
	} else {
		$file = "php.d/$conf_file.ini"
	}

	augeas {
		"change_php_setting_${name}":
			context => "/files/etc/$file",
			changes => "set ${name} ${ensure}",
			require => Package["php-fpm"],
			notify => Service["php-fpm"],
	}
}

