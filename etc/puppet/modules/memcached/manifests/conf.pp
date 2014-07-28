define memcached::conf($ensure) {
	augeas {
		"change_memcached_setting_${name}":
			context => "/files/etc/sysconfig/memcached",
			changes => "set ${name} ${ensure}",
			require => Package["memcached"],
			notify => Service["memcached"],
	}
}

