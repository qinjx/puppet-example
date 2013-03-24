class yum
{
	include fast_yum_repo
	include php_yum_repo
	include percona_yum_repo
	include pptp_yum_repo

	define repo::switcher($ensure)
	{
		if ("disabled" == $ensure)
		{
			$enabled_flag = 0
		}
		else
		{
			$enabled_flag = 1
		}

		augeas
		{
			"change_yumrepo_${name}_to_${ensure}":
				changes => [
					"set /files/etc/yum.repos.d/${name}.repo/${name}/enabled ${enabled_flag}",
				],
		}
	}
}