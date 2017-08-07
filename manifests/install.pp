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
    # If the module manage the bareos repository (apt or yum),
    # we should add the source repository and update package list
    # before install any other package.
    include ::bareos::install::repo
    Class['::bareos::install::repo']
    -> Class['::bareos::install::common']
    -> Class['::bareos::install::file']
    -> Class['::bareos::install::storage']
    -> Class['::bareos::install::director']
    -> Class['::bareos::install::webui']
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
