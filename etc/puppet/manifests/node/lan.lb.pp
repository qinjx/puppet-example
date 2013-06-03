node /^lan\d*\.lb/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[lan_lb_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[lan_lb_vip]}/24",
	}

	haproxy::conf::cluster {
		"shop_db":
			port => 3306;
		"shop_se":
			port => 9312;
		"php_app":
			port => 9000;
		"acp-php_app":
			port => 9001;
	}

	haproxy::conf::server {
		["shop1.db", "shop2.db", "shop3.db"]:
			port => 3306,
			cluster => "shop_db";
		["shop1.se", "shop2.se", "shop3.se"]:
			port => 9312,
			cluster => "shop_se";
		["php1.app", "php2.app", "php3.app"]:
			port => 9000,
			cluster => "php_app";
		["acp-php1.app", "acp-php2.app", "acp-php3.php"]:
			port => 9000,
			cluster => "acp-php_app";
	}

	include role_vip_holder, role_load_balancer
}
