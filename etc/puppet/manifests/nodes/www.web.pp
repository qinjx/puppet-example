node /^www\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server

	$app_name = "www"
	include role_lotusphp_app_server
}
