# Class: bareos::install::director
#
# This class contain the packages for bareos director installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::install::director
#
class bareos::install::director {

  # director packages

  package { $bareos::params::package_director:         ensure => installed; }
  package { $bareos::params::package_database_common:  ensure => installed; }
  package { $bareos::params::package_database_mysql:   ensure => installed; }
  package { $bareos::params::package_database_tools:   ensure => installed; }
  package { $bareos::params::package_console:          ensure => installed; }
}
