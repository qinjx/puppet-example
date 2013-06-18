define ssh::server::conf($ensure) {
	augeas {
		"change_sshd_config_$name":
			context => "/files/etc/ssh/sshd_config",
			changes => "set $name $ensure",
			notify => Service["sshd"],
	}
}
