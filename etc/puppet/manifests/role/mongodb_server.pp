class role_mongodb_server {

  yum::repo::conf {
    ["epel"]:
  }
	include mongodb::install, mongodb::service
}
