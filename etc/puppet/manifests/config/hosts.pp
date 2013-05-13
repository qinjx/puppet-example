class config::hosts {
	define set($ip) {
		host {
			$name:
				ip => "$config::global::ip_prefix.$ip",
				name => "$name.$config::global::root_domain_name",
				host_aliases => [$name];
		}
	}
}

config::hosts::set {
	"puppet-server.vip": ip => "252";
	"yum-mirror.vip": ip => "5"
}
