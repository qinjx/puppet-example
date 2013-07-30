node default {
	yum::repo::conf {
		["centos_base", "centos_updates", "centos_extras", "epel"]:
	}

	hosts::conf {
		$config::hosts::ip_keys:
	}

	include role_ssh_server
}
