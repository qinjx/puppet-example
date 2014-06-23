class role_ntp_client {
	include ntp::client::service, ntp::client::install, ntp::client::conf
}
