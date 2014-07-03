class compiler::rpm {
	package {
		["rpmdevtools"]:
	}

	exec {
		"rpm_setup_tree":
			command => "/usr/bin/rpmdev-setuptree",
	}
}
