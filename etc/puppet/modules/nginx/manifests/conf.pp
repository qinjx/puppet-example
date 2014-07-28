define nginx::conf($ensure) {
	augeas {
		"change_nginx_setting_${name}":
			context => "/files/etc/nginx/nginx.conf",
			changes => "set ${name} ${ensure}",
			require => Package["nginx"],
			notify => Service["nginx"],
	}
}

