# Class: bareos::config::webui
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
class bareos::config::webui {

  # Webui configuration
  file {
    $bareos::params::config_webui:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_webui_template),
      notify  => Service[$bareos::params::service_webui],
      require => Package[$bareos::params::package_webui];

    $bareos::params::config_confd_webui_consoles:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_webui_consoles_template),
      notify  => Service[$bareos::params::service_webui],
      require => Package[$bareos::params::package_webui];

    $bareos::params::config_confd_webui_profiles:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_webui_profiles_template),
      notify  => Service[$bareos::params::service_webui],
      require => Package[$bareos::params::package_webui];
  }

}
