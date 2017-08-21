# Class: bareos::install::storage
#
# This class contain the packages for bareos storage daemon installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::install::storage
#
class bareos::install::storage {

  # Common packages
  package { $bareos::params::package_storage:            ensure => installed; }
  package { $bareos::params::package_storage_fifo:       ensure => installed; }

  # The package `bareos-storage-glusterfs` is not available for Debian 7,
  # cf. http://doc.bareos.org/master/html/bareos-manual-main-reference.html#x1-463000B.1.1
  if ($::osfamily == 'Debian') and ($::lsbmajdistrelease == '7') {
    package { $bareos::params::package_storage_glusterfs:  ensure => absent; }
  } else {
    package { $bareos::params::package_storage_glusterfs:  ensure => installed; }
  }

  package { $bareos::params::package_storage_tape:       ensure => installed; }
}
