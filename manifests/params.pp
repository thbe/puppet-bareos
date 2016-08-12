# Class: bareos::params
#
# This module manages bareos parameter
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::params
#
class bareos::params {
  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux                                      = true

      # Package definition
      $package_repository                         = '/etc/yum.repos.d/bareos.repo'
      $package_common                             = 'bareos-common'
      $package_file_daemon                        = 'bareos-filedaemon'
      $package_file_daemon_glusterfs_plugin       = 'bareos-filedaemon-glusterfs-plugin'
      $package_storage                            = 'bareos-storage'
      $package_storage_fifo                       = 'bareos-storage-fifo'
      $package_storage_glusterfs                  = 'bareos-storage-glusterfs'
      $package_storage_tape                       = 'bareos-storage-tape'
      $package_director                           = 'bareos-director'
      $package_database_common                    = 'bareos-database-common'
      $package_database_mysql                     = 'bareos-database-mysql'
      $package_database_tools                     = 'bareos-database-tools'
      $package_console                            = 'bareos-bconsole'
      $package_webui                              = 'bareos-webui'

      # Config definition
      $config_file                                = '/etc/bareos/bareos-fd.conf'
      $config_file_template                       = 'bareos/etc/bareos-fd.conf.erb'
      $config_storage                             = '/etc/bareos/bareos-sd.conf'
      $config_storage_template                    = 'bareos/etc/bareos-sd.conf.erb'
      $config_director                            = '/etc/bareos/bareos-dir.conf'
      $config_director_template                   = 'bareos/etc/bareos-dir.conf.erb'
      $config_console                             = '/etc/bareos/bconsole.conf'
      $config_console_template                    = 'bareos/etc/bconsole.conf.erb'
      $config_webui                               = '/etc/bareos-webui/directors.ini'
      $config_webui_template                      = 'bareos/etc/directors.ini.erb'
      $config_confd_dir                           = '/etc/bareos/bareos-dir.d'
      $config_confd_clients_dir                   = '/etc/bareos/bareos-dir.d/clients'
      $config_confd_jobs_dir                      = '/etc/bareos/bareos-dir.d/jobs'
      $config_confd_catalog                       = '/etc/bareos/bareos-dir.d/catalog.conf'
      $config_confd_catalog_template              = 'bareos/etc/bareos-dir.d/catalog.conf.erb'
      $config_confd_client_director               = '/etc/bareos/bareos-dir.d/client-director.conf'
      $config_confd_client_director_template      = 'bareos/etc/bareos-dir.d/client-director.conf.erb'
      $config_confd_console                       = '/etc/bareos/bareos-dir.d/console.conf'
      $config_confd_console_template              = 'bareos/etc/bareos-dir.d/console.conf.erb'
      $config_confd_director                      = '/etc/bareos/bareos-dir.d/director.conf'
      $config_confd_director_template             = 'bareos/etc/bareos-dir.d/director.conf.erb'
      $config_confd_fileset                       = '/etc/bareos/bareos-dir.d/fileset.conf'
      $config_confd_fileset_template              = 'bareos/etc/bareos-dir.d/fileset.conf.erb'
      $config_confd_job_backup_catalog            = '/etc/bareos/bareos-dir.d/job-backup-catalog.conf'
      $config_confd_job_backup_catalog_template   = 'bareos/etc/bareos-dir.d/job-backup-catalog.conf.erb'
      $config_confd_job_director                  = '/etc/bareos/bareos-dir.d/job-director.conf'
      $config_confd_job_director_template         = 'bareos/etc/bareos-dir.d/job-director.conf.erb'
      $config_confd_job_restore                   = '/etc/bareos/bareos-dir.d/job-restore.conf'
      $config_confd_job_restore_template          = 'bareos/etc/bareos-dir.d/job-restore.conf.erb'
      $config_confd_jobdefs                       = '/etc/bareos/bareos-dir.d/jobdefs.conf'
      $config_confd_jobdefs_template              = 'bareos/etc/bareos-dir.d/jobdefs.conf.erb'
      $config_confd_messages                      = '/etc/bareos/bareos-dir.d/messages.conf'
      $config_confd_messages_template             = 'bareos/etc/bareos-dir.d/messages.conf.erb'
      $config_confd_pool                          = '/etc/bareos/bareos-dir.d/pool.conf'
      $config_confd_pool_template                 = 'bareos/etc/bareos-dir.d/pool.conf.erb'
      $config_confd_schedule                      = '/etc/bareos/bareos-dir.d/schedule.conf'
      $config_confd_schedule_template             = 'bareos/etc/bareos-dir.d/schedule.conf.erb'
      $config_confd_storage                       = '/etc/bareos/bareos-dir.d/storage.conf'
      $config_confd_storage_template              = 'bareos/etc/bareos-dir.d/storage.conf.erb'
      $config_confd_webui_consoles                = '/etc/bareos/bareos-dir.d/webui-consoles.conf'
      $config_confd_webui_consoles_template       = 'bareos/etc/bareos-dir.d/webui-consoles.conf.erb'
      $config_confd_webui_profiles                = '/etc/bareos/bareos-dir.d/webui-profiles.conf'
      $config_confd_webui_profiles_template       = 'bareos/etc/bareos-dir.d/webui-profiles.conf.erb'

      $config_confd_storage_dir                   = '/etc/bareos/bareos-sd.d'

      $config_schema_script                       = '/etc/bareos/populate_bareos_schema.sh'
      $config_schema_script_file                  = 'puppet:///modules/bareos/etc/populate_bareos_schema.sh'

      $config_confd_client_template               = 'bareos/etc/bareos-dir.d/client-template.conf.erb'
      $config_confd_job_template                  = 'bareos/etc/bareos-dir.d/job-template.conf.erb'

      # Service definition
      $service_file_daemon                        = 'bareos-fd'
      $service_storage                            = 'bareos-sd'
      $service_director                           = 'bareos-dir'
      $service_webui                              = 'httpd'
    }
    default  : {
      $linux                                      = false
    }
  }

  # bareos definitions
  $db_password              = '0nly4install'
  $db_password_hash         = '*31F96A5E321BF3E06E35668ED982CC2447CF5B3F'
  $client_password          = 'client-password-for-bareos'
  $monitor_password         = 'monitor-password-for-bareos'
  $storage_password         = 'storage-password-for-bareos'
  $storage_daemon           = 'storage-daemon.domain.local'
  $mail_hub                 = 'mail-hub.domain.local'
  $mail_group               = 'bareos-list@domain.local'
}
