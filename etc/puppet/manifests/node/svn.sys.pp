node /^svn\d*\.sys/ inherits default {
	include svn::install, svn::service
}
