class role_puppet_client {
	include puppet_client
	
	puppet_client::conf {
		"agent/runinterval":
			ensure => 300,
			require => Class["puppet_client"];
		"agent/show_diff":
			ensure => "true",
                        require => Class["puppet_client"];
		"agent/pluginsync":
			ensure => "false",
                        require => Class["puppet_client"];
	}
}
