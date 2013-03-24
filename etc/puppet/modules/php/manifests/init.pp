class php
{
	yum::repo::switcher
	{
		"php":
			ensure => enabled,
			require => Yumrepo["php"],
	}

	include php_service
	include php_user
	include php_extensions
}
