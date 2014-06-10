class redis::service {
	service {
		"redis":
			require => Class["redis::install"],
	}
}
