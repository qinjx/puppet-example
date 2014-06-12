class role_compiler {
	yum::repo::conf {
		"remi":
	}
	include compiler::general, compiler::nginx, compiler::php, compiler::fastdfs, compiler::coreseek
}
