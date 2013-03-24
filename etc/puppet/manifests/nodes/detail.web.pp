node /^detail\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server
	include role_vpn_enduser

	$app_name = "detail"
	include role_lotusphp_app_server
}
