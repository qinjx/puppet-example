class haproxy::install {
	package {
		"haproxy":
			require => Yum::Repo::Conf["epel"],
	}

	file {
		"/etc/haproxy/conf.d":
			ensure => directory,
			require => Package["haproxy"];
		"/etc/haproxy/conf.d/stats.cfg":
			source => "puppet:///modules/haproxy/stats.cfg";
	}

	firewall::filter::allow {
		"1936":#for haproxy stats
	}

	exec {#多个配置文件要指定多次-f参数
		"inert_conf_array_line":
			command => 'sed -i "/prog=/ a conf_array=\`find /etc/haproxy -name \'*.cfg\' | sort -r | awk \'{print \"-f \", \$1}\'\`" /etc/init.d/haproxy',
			unless => "grep conf_array= /etc/init.d/haproxy",
			require => Package["haproxy"];

		"enable_multi_config_file_for_haproxy":
			command => 'sed -i "s/\-f \/etc\/\$prog\/\$prog\.cfg/\$\{conf_array\[@\]\}/g" /etc/init.d/haproxy',
			unless => "grep 'conf_array\[@' /etc/init.d/haproxy",
			require => Package["haproxy"];

		"truncate_default_haproxy_cfg":
			command => "sed -i '/main/,\$d' /etc/haproxy/haproxy.cfg",
			onlyif => "grep main /etc/haproxy/haproxy.cfg",
			require => Package["haproxy"];

		"set_maxconn":
			command => "sed -i 's/maxconn\( \+[0-9]\+\)/maxconn\10/' /etc/haproxy/haproxy.cfg",
                        onlyif => "grep maxconn /etc/haproxy/haproxy.cfg | grep 3000\$",
                        require => Package["haproxy"]
	}
}
