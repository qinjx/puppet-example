class pptp::server::service {
	"pptpd":
		ensure => running,
		enable => true,
		require => Class["pptp::server::install"],
}