node /^mongo\d*\.db/ inherits default {
	include mongodb::install, mongodb::service
}