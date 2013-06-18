define php::conf::fpm ($pool = nil, $section = nill, $ensure) {
	if ($pool == nil) {
		$ini_file = "/etc/php-fpm.conf"
	} else {
		$ini_file = "/etc/php-fpm.d/$pool.conf"
		if ($section == nill) {
			$section_name = $pool
		} else {
			$section_name = $section
		}
	}

	ini_setting {
		"php-fpm_conf_$section/$name":
			section => $section_name,
			path => $ini_file,
			setting => $name,
			value => $ensure,
			require => Package["php-fpm"],
		    notify => Service["php-fpm"],
	}
}
