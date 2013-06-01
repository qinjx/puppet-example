class pptp::server::service {
	"pptpd":
		ensure => running,
		enable => true,
		require => Package["pptpd"],
}