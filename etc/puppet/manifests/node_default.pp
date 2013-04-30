node default {
	notify {
		"test_notify_from_default_node":
	}

	file {
		"/root/init_scripts/":
			mode => 755,
			ensure => "directory";

		"/root/init_scripts/config.ini":
			ensure => present;

		"/root/init_scripts/init_vm.sh":
			mode => 755,
			source => "puppet:///node_files/default/init_vn.sh";
	}
}
