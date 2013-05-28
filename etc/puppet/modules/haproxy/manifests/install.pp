class haproxy::install {
	package {
		"haproxy":
			ensure => installed,
			require => Yum::Repo::Conf["epel"],
	}

	file {
		"/etc/haproxy/conf.d":
			ensure => directory,
			require => Package["haproxy"],
	}

	exec {
		"inert_conf_array_line":
			command => 'sed -i "/prog=/ a conf_array=\`ls /etc/haproxy/conf.d\`\
conf_array+=\(\/etc\/\$prog\/\$prog\.cfg)" /etc/init.d/haproxy',
			unless => "grep conf_array /etc/init.d/haproxy 2>/dev/null",
			path => "/bin";

		"enable_multi_config_file_for_haproxy":
			command => 'sed -i "s/\/etc\/\$prog\/\$prog\.cfg/\$\{conf_array\[@\]\}/g" /etc/init.d/haproxy',
			path => "/bin";
	}
}
