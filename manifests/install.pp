# Class: bareos::install
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::install
#
class bareos::install {

  if $bareos::manage_repo {
    include ::bareos::install::repo
  }

  include ::bareos::install::common

  if $bareos::type_fd {
    include ::bareos::install::file
  }

  if $bareos::type_sd {
    include ::bareos::install::storage
  }

  if $bareos::type_dir {
    include ::bareos::install::director
  }

  if $bareos::type_webui {
    include ::bareos::install::webui
  }
}
