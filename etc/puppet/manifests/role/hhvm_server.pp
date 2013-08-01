class role_hhvm_server {
	yum::repo::conf {
		"hop5":
	}

	include hhvm::install, hhvm::service
}
