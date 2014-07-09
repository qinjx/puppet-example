define nfs::mount($dev, $mount_point = $name) {
	exec {
		"mkdir-$mount_point":
			command => "mkdir -p $mount_point",
			unless => "ls $mount_point";
		"write_fstab-$dev-$mount_point":,
			command => "echo '$dev		$mount_point		nfs	defaults	0 0' >> /etc/fstab",
			unless => "grep '$dev' /etc/fstab";
		"refresh_fstab_for_-$mount_point":
			command => "mount -a",
			unless => "df | grep '$mount_point'";
	}
}
