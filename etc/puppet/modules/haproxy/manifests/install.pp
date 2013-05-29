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

	exec {#多个配置文件要指定多次-f参数
		"inert_conf_array_line":
			command => 'sed -i "/prog=/ a conf_array=\`find /etc/haproxy -name \'*.cfg\' | sort -r | awk \'{print \"-f \", \$1}\'\`" /etc/init.d/haproxy',
			unless => "grep conf_array= /etc/init.d/haproxy 2>/dev/null",
			path => "/bin",
			require => Package["haproxy"];

		"enable_multi_config_file_for_haproxy":
			command => 'sed -i "s/\-f \/etc\/\$prog\/\$prog\.cfg/\$\{conf_array\[@\]\}/g" /etc/init.d/haproxy',
			path => "/bin",
			require => Package["haproxy"];
	}
}
