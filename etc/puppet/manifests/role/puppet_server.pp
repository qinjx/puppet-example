class role_puppet_server {
	include puppet::master::install, puppet::master::service
}
