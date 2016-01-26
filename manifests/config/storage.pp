# Class: bareos::config::storage
#
# This module manages bareos backup storage daemon
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::config::storage
#
class bareos::config::storage {

  # File descriptor configuration
  file {
    $bareos::params::config_storage:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_storage_template),
      notify  => Service[$bareos::params::service_storage],
      require => Package[$bareos::params::package_storage];
  }
}
