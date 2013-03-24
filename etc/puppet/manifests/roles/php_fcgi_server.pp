class role_php_fcgi_server
{
	include php

	augeas
	{
		"php_setting":
			context => "/files/etc/php.ini",
			require => Package["php-fpm"],
			changes => [
				"set Date/date.timezone Asia/Chongqing",
				"set PHP/display_errors Off",
			],
			notify => Service["php-fpm"],
	}
}
