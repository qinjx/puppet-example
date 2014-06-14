node /^php\d*\.app/ inherits default {
	include role_php_app_server, role_nfs_client
}