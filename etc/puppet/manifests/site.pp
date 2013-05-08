# the global config
import "config/global.pp"
include config::global

# all role
import "role/*.pp"

# all node define
import "node/*.pp"
