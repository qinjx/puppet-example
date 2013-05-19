node /^nginx\d*\.web/ inherits default {
	web::server::site {
		"www.${config::web::public_domain_name}":
		    www_root => "${config::web::www_root}/www/",
		    fcgi => "php.app.vip",
	}

	include role_web_server
	include config::web
}