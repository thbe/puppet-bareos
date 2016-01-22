# Class: bareos::config::client
#
# This module manages bareos backup clients
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage:
#
define bareos::config::client (
  $client_fqdn      = $title,
  $fileset          = 'UnixServerComplete',
  $file_retention   = '10 days',
  $job_retention    = '30 days'
  ) {

  # Define local variables for template
  $local_client_fqdn     = $client_fqdn
  $local_fileset         = $fileset
  $local_file_retention  = $file_retention
  $local_job_retention   = $job_retention

  # Create client defintion
  file { "${bareos::params::config_confd_clients_dir}/${client_fqdn}.conf":
    ensure  => file,
    mode    => '0644',
    content => template($bareos::params::config_confd_client_template),
    notify  => Service[$bareos::params::service_director],
    require => Package[$bareos::params::package_file];
  }

  # Create job definition
  file { "${bareos::params::config_confd_jobs_dir}/${client_fqdn}.conf":
    ensure  => file,
    mode    => '0644',
    content => template($bareos::params::config_confd_job_template),
    notify  => Service[$bareos::params::service_director],
    require => Package[$bareos::params::package_file];
  }
}
