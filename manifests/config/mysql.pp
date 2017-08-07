# Class: bareos::config::mysql
#
# This class contain the configuration for bareos MySQL databases
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bareos::config::mysql
#
class bareos::config::mysql {
  # Setup mysql databases
  class { '::mysql::server':
    root_password    => $bareos::db_password,
    override_options => {
      'mysqld' => {
        'max_connections' => '1024',
        },
      },
    databases        => {
      'bareos' => {
        # lint:ignore:ensure_first_param
        ensure  => present,
        # lint:endignore
        charset => 'utf8',
      },
    },
    grants           => {
      'bareos@localhost/bareos.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'ALL' ],
        table      => 'bareos.*',
        user       => 'bareos@localhost',
      },
    },
    users            => {
      'bareos@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => $bareos::db_password_hash,
      },
    },
  }

  class { '::mysql::server::backup':
    backupdir      => '/srv/mysql',
    backuppassword => $bareos::db_password,
    backupuser     => 'bckadm',
  }

  include ::mysql::server::account_security
  include ::mysql::server::mysqltuner

  case $::osfamily {
    'Debian': {
      $script_directory = '/usr/lib/bareos/scripts'
      $db_parameters = "--password=${bareos::params::db_password}"
      $db_type = 'mysql'

      # Setting up the Bareos database tables
      # exec { 'create_bareos_database':
      #   command => "$script_directory/create_bareos_database ${db_type} ${db_parameters}",
      #   require => Package[$bareos::params::package_database_mysql]
      # }

      exec { 'make_bareos_tables':
        command     => "${script_directory}/make_bareos_tables ${db_type} ${db_parameters}",
        subscribe   => Package[$bareos::params::package_database_mysql],
        refreshonly => true,
      }

      exec { 'grant_bareos_privileges':
        command     => "${script_directory}/grant_bareos_privileges ${db_type} ${db_parameters}",
        subscribe   => Package[$bareos::params::package_database_mysql],
        refreshonly => true,
      }
    }
    'RedHat': {
      # Create schema population script
      file { $bareos::params::config_schema_script:
        ensure  => file,
        mode    => '0755',
        source  => $bareos::params::config_schema_script_file,
        require => Package[$bareos::params::package_database_mysql];
      }

      # Execute schema population script
      exec { '/etc/bareos/populate_bareos_schema.sh':
        path   => '/bin:/sbin:/usr/bin:/usr/sbin',
        onlyif => 'test -x /etc/bareos/populate_bareos_schema.sh',
        unless => 'test -f /etc/sysconfig/mysqldb_bareos',
      }
    }
    default: {
      warning('The current operating system is not supported!')
    }
  }
}
