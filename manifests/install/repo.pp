# == Class: bareos::install::repo
#
# This class contain the repository for bareos packages
#
class bareos::install::repo {

  case $::osfamily {
    'Debian' : {
      include ::apt

      apt::source { 'bareos':
        location => 'http://download.bareos.org/bareos/release/latest/Debian_8.0/',
        repos    => '',
        release  => '/',
        key      => {
          'id'     => '0143857D9CE8C2D182FE2631F93C028C093BFBA2',
          'source' => 'http://download.bareos.org/bareos/release/latest/Debian_8.0/Release.key',
        },
        notify   => Exec['apt_update'],
      }
    }
    'RedHat' : {
      # Define repository
      $bareos_version = '15-2'

      case $::lsbdistid {
        'CentOS': {
          $repository_file = "c${::lsbmajdistrelease}_${bareos_version}.repo"
        }
        default: {
          $repository_file = "rhel${::lsbmajdistrelease}_15-2.repo"
        }
      }
      $module_repository_file = "puppet:///modules/bareos/repo/${repository_file}"

      # Create client defintion
      file { $bareos::params::package_repository:
        ensure => file,
        mode   => '0644',
        notify => Exec['rpm-key-import', 'yum-update-cache'],
        source => $module_repository_file;
      }

      # yum/rpm configuration
      exec { 'rpm-key-import':
        command     => 'rpm --import http://download.bareos.org/bareos/release/15.2/CentOS_7/repodata/repomd.xml.key',
        path        => '/bin:/sbin:/usr/bin:/usr/sbin',
        refreshonly => true,
      }

      exec { 'yum-update-cache':
        command     => 'yum clean all && yum makecache',
        path        => '/bin:/sbin:/usr/bin:/usr/sbin',
        refreshonly => true,
      }
    }
    default : {
      warning ('os not (yet) supported!')
    }
  }
}
