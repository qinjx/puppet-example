class role_search_engine {
	yum::repo::conf {
		"mysql":
	}

	include sphinx::install, sphinx::service
}

