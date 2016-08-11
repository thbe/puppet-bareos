# Class: bareos::package::storage
#
# This class contain the packages for bareos storage daemon installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::package::storage
#
class bareos::package::storage {

  # Common packages
  package { $bareos::params::package_storage:            ensure => installed; }
  package { $bareos::params::package_storage_fifo:       ensure => installed; }
  package { $bareos::params::package_storage_glusterfs:  ensure => installed; }
  package { $bareos::params::package_storage_tape:       ensure => installed; }
}
