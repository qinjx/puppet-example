node /^order\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server
	include role_vpn_enduser

	$app_name = "order"
	include role_lotusphp_app_server
}
