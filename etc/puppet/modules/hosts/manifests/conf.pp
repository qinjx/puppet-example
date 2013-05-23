define hosts::conf {
	$host_domain = regsubst($name, '_', '.', 'G')
	$ip_suffix = $config::hosts::ip_list[$name]
	host {
		$host_domain:
			ip => "$config::global::ip_prefix.$ip_suffix",
			name => "$host_domain.$config::global::root_domain_name",
			host_aliases => [$host_domain],
	}
}
