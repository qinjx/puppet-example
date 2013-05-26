node /^nginx\d*\.web/ inherits default {
	nginx::conf::vhost {
		"www.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/www",
			fcgi_conf => "php",
	}

	nginx::conf::location {
		"php":
			pattern => "\\.php\$",
			fcgi_address => "${config::global::ip_prefix}.${config::hosts::ip_list[php1_app]}:9000",
	}

	include role_web_server
}
