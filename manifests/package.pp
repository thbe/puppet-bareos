# Class: bareos::package
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::package
#
class bareos::package {

  if $bareos::manage_repo {
    include bareos::package::repo
  }

  include bareos::package::common

  if $bareos::type_fd {
    include bareos::package::file
  }

  if $bareos::type_sd {
    include bareos::package::storage
  }

  if $bareos::type_dir {
    include bareos::package::director
  }
}
