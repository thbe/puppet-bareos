# Class: bareos::config::file
#
# This module manages bareos backup file descriptor
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::config::file
#
class bareos::config::file {

  # File descriptor configuration
  file {
    $bareos::params::config_file:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_file_template),
      notify  => Service[$bareos::params::service_file],
      require => Package[$bareos::params::package_file];
  }
}
