class role_mysql_server {
  yum::repo::conf {
    "mysql":
  }

  mysql::server::conf {
    "datadir":
      ensure => "/opt/data/mysql"
  }

  include mysql::server::install, mysql::server::service
}