class ntp::install {
	package {
		["ntp", "rdate"]:
	}

	cron {
		"adj_time_by_rdate":
			command => "/usr/bin/rdate -s rdate.darkorb.net",
			minute => "*/30",
	}
}
