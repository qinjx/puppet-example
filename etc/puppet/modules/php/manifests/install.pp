class php::install {
	package {
		"php-fpm":
			require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"9000":
	}

	user {
		"php":
			ensure => present,
	}

	exec {
		"delete_default_setting_in_php_fpm_conf":
			command => "/bin/sed -i '/Additional/,\$d' /etc/php-fpm.d/www.conf",
			require => Package["php-fpm"],
	}
}
