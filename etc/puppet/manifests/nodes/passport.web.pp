node /^passport\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server

	$app_name = "passport"
	include role_lotusphp_app_server

	include role_secure_web_server
}
