class yum::repo::percona inherits yum::repo::base {
	Yumrepo["percona"] {
		enabled => 1
	}
}
