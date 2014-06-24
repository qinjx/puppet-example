node /^puppet\-server\d*\.sys/ inherits default {
	include puppet::master::install, puppet::master::service
}
