node /^redis\d*\.cache/ inherits default {
	include role_redis_server
}