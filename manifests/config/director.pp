# Class: bareos::config::director
#
# This module manages bareos backup director
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::config::director
#
class bareos::config::director {

  # Setup bareos director
  file {
    $bareos::params::config_confd_dir:
      ensure  => directory,
      mode    => '0755',
      path    => $bareos::params::config_confd_dir;

    $bareos::params::config_confd_storage_dir:
      ensure  => directory,
      mode    => '0755',
      path    => $bareos::params::config_confd_storage_dir;

    $bareos::params::config_confd_clients_dir:
      ensure  => directory,
      mode    => '0755',
      path    => $bareos::params::config_confd_clients_dir;

    $bareos::params::config_confd_jobs_dir:
      ensure  => directory,
      mode    => '0755',
      path    => $bareos::params::config_confd_jobs_dir;

    $bareos::params::config_director:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_director_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_catalog:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_catalog_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_client_director:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_client_director_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_console:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_console_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_director:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_director_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_fileset:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_fileset_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_job_backup_catalog:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_job_backup_catalog_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_job_director:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_job_director_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_job_restore:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_job_restore_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_jobdefs:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_jobdefs_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_messages:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_messages_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_pool:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_pool_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_schedule:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_schedule_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];

    $bareos::params::config_confd_storage:
      ensure  => file,
      mode    => '0644',
      content => template($bareos::params::config_confd_storage_template),
      notify  => Service[$bareos::params::service_director],
      require => Package[$bareos::params::package_director];
  }

  # Create client configuration
  bareos::config::client { $bareos::backup_clients : }
}
