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

  exec {
    "change_mysqld_datadir":
      command => "/etc/init.d/mysqld stop; /bin/cp -rp /var/lib/mysql /opt/data/; /etc/init.d/mysqld start",
      require => Mysql::Server::Conf["datadir"];
  }

  include mysql::server::install, mysql::server::service
}