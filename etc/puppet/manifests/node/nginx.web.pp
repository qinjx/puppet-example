node /^nginx\d*\.web/ inherits default {
	web::server::site {
		"www.${config::web::public_domain_name}":
			www_root => "${config::web::www_root}/www/",
			fcgi => "php.app.vip:9000",
			require => Class["config::web"]
		
	}

	include config::web, role_web_server
}
