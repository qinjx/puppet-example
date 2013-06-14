define nfs::export() {
    augeas {
		"nfs_export_$name":
		    context => "/files/etc/exports",
		    changes => [
				"set dir[.= '$name'] $name",
				"set dir[.= '$name']/client ${config::global::ip_prefix}.0/24",
				"set dir[.= '$name']/client/option[1] ro",
				"set dir[.= '$name']/client/option[2] all_squash"
			],
	}
}