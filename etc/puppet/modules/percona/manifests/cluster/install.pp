class percona::cluster::install {
	augeas {
		"disable_selinux":
			lens => "Shellvars.lns",
			incl => "/etc/selinux/config",
			changes => "set SELINUX disabled",
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
		"/usr/bin/mysqlchk":
			mode => 755,
			user => nobody,
			group => nobody,
		    content => "MYSQLHOST=\"localhost\"
MYSQLPORT=\"3306\"
MYSQLUSERNAME=\"mgchkusr\"
MYSQLPASSWORD=\"secret\"
 
MYSQLSTATUS1=`mysql --force --host=$MYSQLHOST --port=$MYSQLPORT --user=$MYSQLUSERNAME --password=$MYSQLPASSWORD -B -N -e \"SHOW STATUS WHERE Variable_name = 'wsrep_ready';\" | awk '{print $2}'`
 
if [ $MYSQLSTATUS1 = \"ON\" ]; then
   MYSQLSTATUS2=`mysql --force --host=$MYSQLHOST --port=$MYSQLPORT --user=$MYSQLUSERNAME --password=$MYSQLPASSWORD -B -N -e \"SHOW STATUS WHERE Variable_name = 'wsrep_local_state_comment';\" | awk '{print $2}'`
   if [ $MYSQLSTATUS2 = \"Synced\" ]; then
      echo -e \"HTTP/1.1 200 OK\r\nContent-Type: Content-Type: text/plain\r\n\r\nMySQL Galera is Working\r\n\r\n\"
   else
      echo -e \"HTTP/1.1 503 Service Unavailable\r\nContent-Type: Content-Type: text/plain\r\n\r\nMySQL Galera has Failed.\r\n\r\n\"
   fi
else
   echo -e \"HTTP/1.1 503 Service Unavailable\r\nContent-Type: Content-Type: text/plain\r\n\r\nMySQL Galera has Failed.\r\n\r\n\"
fi";
		"/etc/xinetd.d/mysqlchk":
			mode => 755,
			content => "service mysqlchk
{
        flags           = REUSE
        socket_type     = stream
        port            = 9200
        wait            = no
        user            = nobody
        server          = /usr/bin/mysqlchk
        log_on_failure  += USERID
        disable         = no
        only_from       = 0.0.0.0/0
        per_source      = UNLIMITED
}",
			require => File["/usr/bin/mysqlchk"],
			notify => Service["xinetd"];
	}
}