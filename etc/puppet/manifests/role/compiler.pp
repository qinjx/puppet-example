class role_compiler {
	yum::repo::conf {
		["remi", "mysql"]:
	}
	include compiler::general, compiler::nginx, compiler::php, compiler::fastdfs, compiler::coreseek
}
