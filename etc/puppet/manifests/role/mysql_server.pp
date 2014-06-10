class role_mysql_server {
  yum::repo::conf {
    "mysql":
  }

include mysql::server::install, mysql::server::service
}