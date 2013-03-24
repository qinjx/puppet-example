class role_ssh_term
{
	augeas
	{
		"disable_root_login":
			context => "/files/etc/ssh/sshd_config",
				changes => [
					"set PermitRootLogin no",
				],
	}
}

