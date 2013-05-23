define hosts::conf {
	$host_domain = regsubst($name, '_', '.', 'G')
	host {
		$name:
		ip => "$config::global::ip_prefix.123",
		name => "$host_domain.$config::global::root_domain_name",
		host_aliases => [$host_domain],
	}
}
