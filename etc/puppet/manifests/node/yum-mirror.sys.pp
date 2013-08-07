node /^yum\-mirror\d*\.sys/ inherits default {
	nginx::conf::vhost {
		"static.$config::web::public_domain_name":
		www_root => "${config::web::www_root}/static",
	}

	include role_web_server, role_yum_sync_client
}