package torque.environment

import future.keywords.if

result := { "decision": "Manual" } if {
  input.action_identifier.action_type != "Extend"  
}
