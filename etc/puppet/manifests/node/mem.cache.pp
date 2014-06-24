node /^mem\d*\.cache/ inherits default {
	yum::repo::conf {
		["remi"]:
	}

	include memcached::install, memcached::service
}