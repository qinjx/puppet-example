class role_memcached_server {

  yum::repo::conf {
    ["remi"]:
  }
	include memcached::install, memcached::service
}
