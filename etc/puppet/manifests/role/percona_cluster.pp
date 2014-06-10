class role_mysql_server {
  yum::repo::conf {
    "percona":
  }

include percona::cluster::install, percona::cluster::service
}