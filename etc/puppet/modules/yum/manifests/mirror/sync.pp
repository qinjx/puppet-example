class yum::mirror::sync {
	package {
		"wget":
			ensure => installed;
	}

	file {
		"/opt/yum_sync.sh":
			ensure => present,
			source => "puppet:///files/role/yum_sync_client/yum_sync.sh";
	}

	cron {
		"cron_sync_yum_mirror":
			command => "/opt/yum_sync.sh",
			user => root,
			weekday => 7,
			require => [Package["cronie"], Package["wget"], Package["curl"]];
	}
}
