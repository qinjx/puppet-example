define sysctl::conf($ensure = nil, $action="set") {
	augeas {
		"change_sysctl_setting_$name":
			context => "/files/etc/sysctl.conf",
			changes => [
				"$action $name $ensure",
			],
			notify => Exec["refresh_sysctl_for_$name"],
	}

	exec {
		"refresh_sysctl_for_$name":
			command => "sysctl -p",
	}
}
