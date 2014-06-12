node /^nginx\d*\.web/ inherits default {
	nginx::conf::vhost {
		"acp.$config::web::public_domain_name":
			www_root => "${config::web::www_root}/acp",
			fcgi_conf => "acp-php",
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

	include role_web_server, role_nfs_client
}
