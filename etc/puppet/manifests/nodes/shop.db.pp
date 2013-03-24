node /^shop\d*\.db/ inherits default {
	$first_node = "shop1.db"

	include role_db_cluster
}