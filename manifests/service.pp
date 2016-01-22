# Class: bareos::service
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::service
#
class bareos::service {

  if $bareos::type_fd {
    include bareos::service::file
  }

  if $bareos::type_sd {
    include bareos::service::storage
  }

  if $bareos::type_dir {
    include bareos::service::director
  }
}
