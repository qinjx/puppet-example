class config::hosts {
	define set {
		host {
			$name:
				ip => "$config::global::ip_prefix.$ip",
				name => "$name.$config::global::root_domain_name",
				host_alias => [$name];
		}
	}
}

config::hosts::set {
	"puppet-server.vip": ip => "252";
	"yum-mirror.vip": ip => "5"
}
