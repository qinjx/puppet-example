class compiler::php {
	package {
		["php", "php-devel", "autoconf"]:
		    require => Yum::Repo::Conf["remi"],
	}
}