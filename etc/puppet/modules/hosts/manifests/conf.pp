define hosts::conf {
	host {
		$name:
		ip => "$config::global::ip_prefix.$ip",
		name => "$name.$config::global::root_domain_name",
		host_aliases => [$name],
	}
}