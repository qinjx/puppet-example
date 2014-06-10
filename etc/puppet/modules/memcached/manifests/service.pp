class memcached::service {
	service {
		"memcached":
      restart => "/sbin/service memcached reload",
			require => Class["memcached::install"],
	}
}
