node /^redis\d*\.cache/ inherits default {
	yum::repo::conf {
		["remi"]:
	}

	include redis::install, redis::service
}