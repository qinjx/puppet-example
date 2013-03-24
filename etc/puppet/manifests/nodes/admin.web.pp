node /^admin\d*\.web/ inherits default {
	include role_web_server
	include role_php_fcgi_server
	include role_vpn_enduser

	#####################this is for ecshop admin, like static
	# admin机不由puppet管理，应用发布脚本参见admin机器上的sh文件
	#####################this is for ecshop admin, like static end #################
	
	# this is for lotusphp_app: acp, like detial, www, help etc
	$app_name = "acp"
	include role_lotusphp_app_server
}
