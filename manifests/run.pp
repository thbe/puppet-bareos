# Class: bareos::run
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::run
#
class bareos::run {

  if $bareos::type_fd {
    include bareos::run::file
  }

  if $bareos::type_sd {
    include bareos::run::storage
  }

  if $bareos::type_dir {
    include bareos::run::director
  }
}
