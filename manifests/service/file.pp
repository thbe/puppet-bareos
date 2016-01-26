# Class: bareos::service::file
#
# This class contain the service configuration for bareos
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::service::file
#
class bareos::service::file {

  # bareos service configuration
  service {
    $bareos::params::service_file_daemon:
      ensure  => 'running',
      enable  => true,
      require => Package[$bareos::params::package_file_daemon];
  }
}
