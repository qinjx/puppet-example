define php::conf($ensure) {
	augeas {
		"change_php_setting_${name}":
		changes => "set /files/etc/php.ini/target[. = 'mysqld']/${name} ${ensure}",
	}
}