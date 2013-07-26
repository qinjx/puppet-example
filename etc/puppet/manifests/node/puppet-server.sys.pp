node /^puppet\-server\d*\.sys/ inherits default {
	include role_puppet_server, role_ntp_server
}
