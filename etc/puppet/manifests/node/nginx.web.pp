node /^nginx\d*\.web/ inherits default {
	include role_web_server
}