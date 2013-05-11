class role_puppet_client {
	include puppet::client::service
	
	puppet::client::conf {
		"agent/runinterval":
			ensure => 1500;
		"agent/show_diff":
			ensure => "true";
		"agent/pluginsync":
			ensure => "true";
	}
}
