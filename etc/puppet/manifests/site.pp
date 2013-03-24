#################### Global setting and default node start ####################
#the configuration file
import "config.pp"
import "default_node.pp"
import "centos.vmtpl.pp"
####################  Global setting and default node end  ####################

# the roles
import "roles/*.pp"

# the nodes
import "nodes/*.pp"
