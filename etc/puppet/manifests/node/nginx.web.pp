node /^nginx\d*\.web/ inherits default {
	nginx::conf::vhost {
		"www.$config::web::public_domain_name":
		www_root => "${config::web::www_root}/www"
	}

	include role_web_server
}
