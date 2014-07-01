define redis::conf($ensure) {
	augeas {
		"cahnge_redis_setting_$name":
			lens => "Spacevars.simple_lns",
			incl => "/etc/redis.conf",
			changes => [
				"set $name $ensure",
			],
			notify => Service["redis"],
	}
}
