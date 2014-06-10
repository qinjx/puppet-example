class role_redis_server {
  yum::repo::conf {
    ["remi"]:
  }
	include redis::install, redis::service
}
