class percona_yum_repo inherits base_yum_repo {
	Yumrepo["percona"] {
		enabled => 1
	}
}
