node /^percona\d*\.db/ inherits default {
	yum::repo::conf {
		"percona":
	}

	include percona::cluster::install, percona::cluster::service
}