class virtmanager::service {
	service {
		"libvirtd":
			require => Class["virtmanager::install"],
	}
}