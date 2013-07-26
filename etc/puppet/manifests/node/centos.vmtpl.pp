node /^centos\d*\.vmtpl/ inherits default {
	include role_centos_vmtpl, role_ntp_client
}
