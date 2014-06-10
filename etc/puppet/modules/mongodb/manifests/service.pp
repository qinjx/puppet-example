class mongodb::service {
	service {
		"mongodb":
			require => Class["mongodb::install"],
	}
}
