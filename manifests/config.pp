# Class: bareos::config
#
# This class contain the configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::config
#
class bareos::config {
  include bareos::config::user

  if $bareos::type_fd {
    include bareos::config::file
  }

  if $bareos::type_sd {
    include bareos::config::storage
  }

  if $bareos::type_dir {
    include bareos::config::mysql
    include bareos::config::director
  }

  if $bareos::type_webui {
    include bareos::config::webui
  }
}
