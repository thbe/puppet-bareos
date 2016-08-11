# Class: bareos::run::webui
#
# This module manages bareos webui
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage:
#
class bareos::run::webui {

  # bareos webui service configuration
  service {
    $bareos::params::service_webui:
      ensure  => 'running',
      enable  => true,
      require => Package[$bareos::params::package_webui];
  }
}
