class ntopng::service {
	service {
		"ntopng":
			require => Class["ntopng::install"],
	}
}
