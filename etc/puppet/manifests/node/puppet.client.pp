node /^puppet\-client/ inherits default {
	include fast_yum_repo
	include percona_yum_repo
}
