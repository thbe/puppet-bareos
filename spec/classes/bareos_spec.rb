require 'spec_helper'

describe 'bareos', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge( { root_home: '/root', staging_http_get: 'curl' } )
      end
      let(:params) { { type_fd: true, type_sd: true, type_dir: true, type_webui: true, backup_clients: ['client01.example.local', 'client02.example.local'] } }

      it { is_expected.to compile.with_all_deps }

      # operating system specific tests
      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_apt__source('bareos') }
        it { is_expected.to contain_service('apache2').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_exec('grant_bareos_privileges') }
        it { is_expected.to contain_exec('make_bareos_tables') }
        case facts[:lsbmajdistrelease]
        when '7'
          it { is_expected.to contain_package('bareos-storage-glusterfs').with_ensure('absent') }
        when '8'
          it { is_expected.to contain_package('bareos-storage-glusterfs').with_ensure('installed') }
        end
      when 'RedHat'
        it { is_expected.to contain_file('/etc/yum.repos.d/bareos.repo').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/populate_bareos_schema.sh').with_ensure('file') }
        it { is_expected.to contain_service('httpd').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_exec('rpm-key-import') }
        it { is_expected.to contain_exec('yum-update-cache') }
        it { is_expected.to contain_exec('/etc/bareos/populate_bareos_schema.sh') }
        it { is_expected.to contain_package('bareos-storage-glusterfs').with_ensure('installed') }
      end

      it { is_expected.to contain_class('bareos::params') }
      it { is_expected.to contain_class('bareos::install') }
      it { is_expected.to contain_class('bareos::install::common') }
      it { is_expected.to contain_class('bareos::install::repo') }
      it { is_expected.to contain_class('bareos::install::file') }
      it { is_expected.to contain_class('bareos::install::storage') }
      it { is_expected.to contain_class('bareos::install::director') }
      it { is_expected.to contain_class('bareos::install::webui') }
      it { is_expected.to contain_class('bareos::config') }
      it { is_expected.to contain_class('bareos::config::user') }
      it { is_expected.to contain_class('bareos::config::file') }
      it { is_expected.to contain_class('bareos::config::storage') }
      it { is_expected.to contain_class('bareos::config::mysql') }
      it { is_expected.to contain_class('bareos::config::director') }
      it { is_expected.to contain_class('bareos::config::webui') }
      it { is_expected.to contain_class('bareos::run') }
      it { is_expected.to contain_class('bareos::run::file') }
      it { is_expected.to contain_class('bareos::run::storage') }
      it { is_expected.to contain_class('bareos::run::director') }
      it { is_expected.to contain_class('bareos::run::webui') }

      it { is_expected.to contain_package('bareos-common').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-filedaemon').with_ensure('installed') }
      #it { is_expected.to contain_package('bareos-filedaemon-glusterfs-plugin').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-storage').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-storage-fifo').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-storage-tape').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-director').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-database-common').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-database-mysql').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-database-tools').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-bconsole').with_ensure('installed') }
      it { is_expected.to contain_package('bareos-webui').with_ensure('installed') }

      it { is_expected.to contain_package('bzip2').with_ensure('present') }

      it { is_expected.to contain_file('/etc/bareos/bareos-fd.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-sd.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bconsole.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos-webui/directors.ini').with_ensure('file') }

      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/clients').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/jobs').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/catalog.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/client-director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/console.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/fileset.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/job-backup-catalog.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/job-director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/job-restore.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/jobdefs.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/messages.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/pool.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/schedule.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/storage.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/storage.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/webui-consoles.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/webui-profiles.conf').with_ensure('file') }

      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/clients/client01.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/jobs/client01.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/clients/client02.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bareos/bareos-dir.d/jobs/client02.example.local.conf').with_ensure('file') }

      it { is_expected.to contain_file('/etc/bareos/bareos-sd.d').with_ensure('directory') }

      it { is_expected.to contain_service('bareos-fd').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('bareos-sd').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('bareos-dir').with( 'ensure' => 'running', 'enable' => 'true') }

      it { is_expected.to contain_user('bareos') }
      it { is_expected.to contain_group('bareos') }

      it { is_expected.to contain_Bareos__Config__Client('client01.example.local') }
      it { is_expected.to contain_Bareos__Config__Client('client02.example.local') }

      it { is_expected.to contain_Mysql_database('bareos') }
      it { is_expected.to contain_Mysql_grant('bareos@localhost/bareos.*') }
      it { is_expected.to contain_Mysql_user('bareos@localhost') }

      it 'should generate valid content for bareos-fd.conf' do
        content = catalogue.resource('file', '/etc/bareos/bareos-fd.conf').send(:parameters)[:content]
        expect(content).to match('client-password-for-bareos')
        expect(content).to match('monitor-password-for-bareos')
      end

      it 'should generate valid content for bareos-sd.conf' do
        content = catalogue.resource('file', '/etc/bareos/bareos-sd.conf').send(:parameters)[:content]
        expect(content).to match('storage-password-for-bareos')
        expect(content).to match('monitor-password-for-bareos')
      end

      it 'should generate valid content for bareos-dir.conf' do
        content = catalogue.resource('file', '/etc/bareos/bareos-dir.conf').send(:parameters)[:content]
        expect(content).to match('director.conf')
        expect(content).to match('console.conf')
        expect(content).to match('storage.conf')
        expect(content).to match('catalog.conf')
        expect(content).to match('messages.conf')
        expect(content).to match('pool.conf')
        expect(content).to match('schedule.conf')
        expect(content).to match('fileset.conf')
        expect(content).to match('jobdefs.conf')
        expect(content).to match('/etc/bareos/bareos-dir.d/clients')
        expect(content).to match('/etc/bareos/bareos-dir.d/jobs')
      end

      it 'should generate valid content for webui-consoles.conf' do
        content = catalogue.resource('file', '/etc/bareos/bareos-dir.d/webui-consoles.conf').send(:parameters)[:content]
        expect(content).to match('Name = admin')
        expect(content).to match('Password = webui-password-for-bareos')
      end
    end
  end
end
