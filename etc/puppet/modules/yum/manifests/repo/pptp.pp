class yum::repo::pptp inherits yum::repo::base {
	Yumrepo["pptp"] {
		enabled => 1
	}
}
