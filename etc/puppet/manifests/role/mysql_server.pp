class role_mysql_server {
  yum::repo::conf {
    "mysql":
  }

  mysql::server::conf {
    "datadir":
      ensure => "/opt/data/mysql",
      require => File["/opt/data/mysql"];
  }

  file {
    "/opt/data/mysql":
      ensure => directory;
  }

  include mysql::server::install, mysql::server::service
}