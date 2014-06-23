define ntp::client::conf($ensure) {
	augeas {
		"change_ntp_setting_${name}":
			context => "/files/etc/ntp.conf",
			changes => [
				"rm ${name}[.]",
				"set ${name}  ${ensure}"
			],
			require => Package["ntpdate"],
	}
}
