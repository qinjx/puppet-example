node default {
	yum::repo::conf {
		["centos_base", "centos_updates", "centos_extras", "epel"]:
	}

	hosts::conf {
		$config::hosts::ip_keys:
	}

	file {
		"/root/init_scripts/":
		ensure => directory;

		"/root/init_scripts/conf.ini":
		require => File["/root/init_scripts/"];

		"/root/init_scripts/init.sh":
		source => "puppet:///files/node/default/init.sh";
	}

	include role_ssh_server
}
