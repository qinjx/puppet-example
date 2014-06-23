class compiler::coreseek {
	package {
		["expat-devel", "gcc-c++", "imake", "libtool", "libxml2-devel", "mysql-community-devel"]:
			require => Yum::Repo::Conf["mysql"]
	}
}
