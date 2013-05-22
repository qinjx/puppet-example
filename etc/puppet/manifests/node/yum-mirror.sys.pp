node /^yum\-mirror\d*\.sys/ inherits default {
	include role_web_server
	include role_yum_sync_client
}