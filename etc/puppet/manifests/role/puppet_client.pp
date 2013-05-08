class role_puppet_client {
	include puppet_client
	
	puppet_client::conf {
		"agent/runinterval":
			ensure => 300;
		"agent/show_diff":
			ensure => "true";
		"agent/pluginsync":
			ensure => "true";
	}
}
