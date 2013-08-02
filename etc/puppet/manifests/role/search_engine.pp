class role_search_engine {
	yum::repo::conf {
		"percona":
	}

	include sphinx::install, sphinx::service
}

