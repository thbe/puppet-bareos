# Class: bareos::install::webui
#
# This class contain the packages for bareos webui installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::install::webui
#
class bareos::install::webui {

  # Webui packages
  package { $bareos::params::package_webui: ensure => installed; }
}
