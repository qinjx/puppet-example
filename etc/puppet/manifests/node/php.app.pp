node /^php\d*\.app/ inherits default {
  host {
    $host_domain:
    ip => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}",
    name => "www.${config::web::public_domain_name}",
  }

	include role_php_app_server, role_nfs_client
}