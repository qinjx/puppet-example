define ntp::conf($ensure) {
	augeas {
		"change_ntp_setting_${name}":
		context => "/files/etc/ntp.conf",
		changes => "set ${name} ${ensure}",
		notify => Service["ntp"],
	}
}