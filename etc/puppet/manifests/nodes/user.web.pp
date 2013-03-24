node /^user\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server

	$app_name = "user"
	include role_lotusphp_app_server
}
