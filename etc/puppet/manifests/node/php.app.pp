node /^php\d*\.app/ inherits default {
  host {
    "web_service_www":
    ip => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}",
    name => "www.${config::web::public_domain_name}";

    "user_service_www":
    ip => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}",
    name => "user.${config::web::public_domain_name}";

    "new_service_www":
    ip => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}",
    name => "new.${config::web::public_domain_name}";
  }

  file {
    "/var/lib/php/session":
      mode => 755,
      user => "php",
      group => "php"
  }

	include role_php_app_server, role_nfs_client
}