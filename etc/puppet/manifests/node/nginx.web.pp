node /^nginx\d*\.web/ inherits default {
	nginx::conf::vhost {
		"static.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/static",
	}

	nginx::conf::vhost {
		"img.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/img",
	}

	nginx::conf::vhost {
		"activity.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/activity",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"acp.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/acp",
			fcgi_conf => "acp-php",
	}

	nginx::conf::vhost {
		"detail.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/detail",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"help.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/help",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"order.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/order",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"passport.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/passport",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"search.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/search",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"tuan.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/tuan",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"user.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/user",
			fcgi_conf => "php",
	}

	nginx::conf::vhost {
		"www.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/www",
			fcgi_conf => "php",
	}

	nginx::conf::location {
		"php":
			pattern => "\\.php\$",
			fcgi_address => "${config::global::ip_prefix}.${config::hosts::ip_list[php_app_vip]}:9000",
	}

	nginx::conf::location {
		"acp-php":
			pattern => "\\.php\$",
			fcgi_address => "${config::global::ip_prefix}.${config::hosts::ip_list[acp-php_app_vip]}:9001",
	}

	include role_web_server
}
