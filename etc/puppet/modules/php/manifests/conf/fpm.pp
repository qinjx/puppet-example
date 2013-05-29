define php::conf::fpm ($pool = nil, $section, $ensure) {
	if ($pool == nil) {
		$ini_file = "/etc/php-fpm.conf"
	} else {
		$ini_file = "/etc/php-fpm.d/$pool.conf"
	}

	ini_setting {
		"php-fpm_conf_$section/$name":
			section => $section,
			path => $ini_file,
			setting => $name,
			value => $ensure,
		    require => Class["php::install"],
	}
}
