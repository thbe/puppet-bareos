# Class: bareos::package::file
#
# This class contain the packages for bareos file daemon installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::package::file
#
class bareos::package::file {

  # file packages
  package { $bareos::params::package_file_daemon: ensure => installed; }
  #package { $bareos::params::package_file_daemon_glusterfs_plugin: ensure => installed; }
}
