# the global config
import "config/*.pp"

include config::yum
include config::global
include config::hosts
include config::web
include config::wan

# all role
import "role/*.pp"

# all node define
import "node/*.pp"
