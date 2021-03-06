# Class: bareos::run::director
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::run::director
#
class bareos::run::director {

  # bareos service configuration
  service {
    $bareos::params::service_director:
      ensure  => 'running',
      enable  => true,
      require => Package[$bareos::params::package_director];
  }
}
