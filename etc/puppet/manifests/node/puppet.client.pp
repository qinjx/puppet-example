node /^puppet\-client/ inherits default {
	include yum::repo::base
	include yum::repo::percona
}
