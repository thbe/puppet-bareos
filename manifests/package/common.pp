# Class: bareos::package::common
#
# This class contain the packages for common bareos installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::package::common
#
class bareos::package::common {

  # Common packages
  package { $bareos::params::package_common: ensure => installed; }
}
