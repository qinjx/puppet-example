class mysql::server::install {
	package {
		["mysql-community-server"]:
			require => Yum::Repo::Conf["mysql"],
	}

	file {
		"/var/lib/mysql/init_repl.sh":
			require => Package["mysql-community-server"],
                        source => "puppet:///modules/mysql/init_repl.sh";
                "/var/lib/mysql/repl_sample.ini":
			require => Package["mysql-community-server"],
                        source => "puppet:///modules/mysql/repl_sample.ini";
	}

	firewall::filter::allow {
		"3306":
	}
}
