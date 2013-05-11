class yum::repo::remi inherits yum::repo::base {
	Yumrepo["remi"] {
		enabled => 1
	}
}
