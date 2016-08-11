# Class: bareos::install::common
#
# This class contain the packages for common bareos installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::install::common
#
class bareos::install::common {

  # Common packages
  package { $bareos::params::package_common: ensure => installed; }
}
