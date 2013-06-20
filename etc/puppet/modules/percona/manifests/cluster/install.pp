class percona::cluster::install {
	augeas {
		"disable_selinux":
			lens => "Shellvars.lns",
			incl => "/etc/selinux/config",
			changes => "set SELINUX disabled";
		"add_galerachk_service":
			context => "/files/etc/services",
			changes => [
				"set /files/etc/services/service-name[. = 'galerachk'] galerachk",
				"set /files/etc/services/service-name[. = 'galerachk']/port 9200",
				"set /files/etc/services/service-name[. = 'galerachk']/protocol tcp"
			];
	}

	exec {
		"disable_selinux_now_for_percona_cluster":
			command => "/usr/sbin/setenforce 0",
	}

	package {
		"mysql-libs-5.1.66":
			ensure => absent;
		["Percona-XtraDB-Cluster-server", "Percona-XtraDB-Cluster-client", "xinetd"]:
			require => [Yum::Repo::Conf["percona"], Package["mysql-libs-5.1.66"]];
	}

	firewall::filter::allow {
		["3306", "4444", "4567", "4568", "9200"]:
	}

	file {
		"/usr/bin/galerachk":
				mode => 755,
		    content => "#!/bin/sh
MYSQLHOST=\"localhost\"
MYSQLPORT=\"3306\"
MYSQLUSERNAME=\"mgchkusr\"
MYSQLPASSWORD=\"secret\"
 
MYSQLSTATUS1=`mysql --force --host=\$MYSQLHOST --port=\$MYSQLPORT --user=\$MYSQLUSERNAME --password=\$MYSQLPASSWORD -B -N -e \"SHOW STATUS WHERE Variable_name = 'wsrep_ready';\" | awk '{print \$2}'`
 
if [ \$MYSQLSTATUS1 = \"ON\" ]; then
   MYSQLSTATUS2=`mysql --force --host=\$MYSQLHOST --port=\$MYSQLPORT --user=\$MYSQLUSERNAME --password=\$MYSQLPASSWORD -B -N -e \"SHOW STATUS WHERE Variable_name = 'wsrep_local_state_comment';\" | awk '{print \$2}'`
   if [[ \$MYSQLSTATUS2 = \"Synced\" ]]; then
      echo -e \"HTTP/1.1 200 OK\r\\nContent-Type: Content-Type: text/plain\r\\n\r\\nMySQL Galera is working well\r\\n\r\\n\"
   else
      echo -e \"HTTP/1.1 503 Service Unavailable\r\\nContent-Type: Content-Type: text/plain\r\\n\r\\nMySQL Galera not synced.\r\\n\r\\n\"
   fi
else
   echo -e \"HTTP/1.1 503 Service Unavailable\r\\nContent-Type: Content-Type: text/plain\r\\n\r\\nMySQL Galera not ready.\r\\n\r\\n\"
fi";
		"/etc/xinetd.d/galerachk":
			mode => 755,
			content => "service galerachk
{
        flags           = REUSE
        socket_type     = stream
        port            = 9200
        wait            = no
        user            = nobody
        server          = /usr/bin/galerachk
        log_on_failure  += USERID
        disable         = no
        only_from       = 0.0.0.0/0
        per_source      = UNLIMITED
}",
			require => [File["/usr/bin/galerachk"], Augeas["add_galerachk_service"]],
			notify => Service["xinetd"];
	}
}
