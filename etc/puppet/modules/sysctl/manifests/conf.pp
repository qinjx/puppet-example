define sysctl::conf($ensure = nil, $action="set") {
	augeas {
		"change_sysctl_setting_$name":
			context => "/files/etc/sysctl.conf",
			changes => [
				"$action $name $ensure",
			],
	}
}
