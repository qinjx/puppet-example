# the global config
import "config/global.pp"

# all role
import "role/*.pp"

# all node define
import "node_default.pp"

import "node/*.pp"
