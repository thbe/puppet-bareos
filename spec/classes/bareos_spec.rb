require 'spec_helper'

describe 'bareos', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('bareos') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          :type_fd => true,
          :type_sd => true,
          :type_dir => true,
          :backup_clients => [ 'client01.example.local', 'client02.example.local' ]
        }
      }

      it { is_expected.to compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_class('bareos::package') }
        it { is_expected.to contain_class('bareos::package::common') }
        it { is_expected.to contain_class('bareos::package::file') }
        it { is_expected.to contain_class('bareos::package::storage') }
        it { is_expected.to contain_class('bareos::package::director') }
        it { is_expected.to contain_class('bareos::config') }
        it { is_expected.to contain_class('bareos::config::user') }
        it { is_expected.to contain_class('bareos::config::file') }
        it { is_expected.to contain_class('bareos::config::storage') }
        it { is_expected.to contain_class('bareos::config::mysql') }
        it { is_expected.to contain_class('bareos::config::director') }
        it { is_expected.to contain_class('bareos::service') }
        it { is_expected.to contain_class('bareos::service::file') }
        it { is_expected.to contain_class('bareos::service::storage') }
        it { is_expected.to contain_class('bareos::service::director') }

        it { is_expected.to contain_package('bareos-common').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-client').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-storage-common').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-storage-mysql').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-director-common').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-director-mysql').with_ensure('installed') }
        it { is_expected.to contain_package('bareos-console').with_ensure('installed') }

        it { is_expected.to contain_file('/etc/bareos/conf.d').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/clients').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/jobs').with_ensure('directory') }

        it { is_expected.to contain_file('/etc/bareos/bareos-fd.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/bareos-sd.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/bareos-dir.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/catalog.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/client-director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/console.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/fileset.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/job-backup-catalog.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/job-director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/job-restore.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/jobdefs.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/messages.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/pool.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/schedule.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/storage.conf').with_ensure('file') }

        it { is_expected.to contain_file('/etc/bareos/conf.d/clients/client01.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/jobs/client01.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/clients/client02.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/bareos/conf.d/jobs/client02.example.local.conf').with_ensure('file') }

        it { is_expected.to contain_service('bareos-fd').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_service('bareos-sd').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_service('bareos-dir').with( 'ensure' => 'running', 'enable' => 'true') }

        it { is_expected.to contain_user('bareos') }
        it { is_expected.to contain_group('bareos') }

        it 'should generate valid content for bareos-fd.conf' do
          content = catalogue.resource('file', '/etc/bareos/bareos-fd.conf').send(:parameters)[:content]
          expect(content).to match('client-password-for-bareos')
          expect(content).to match('monitor-password-for-bareos')
          expect(content).to match('FDport')
          expect(content).to match('FDAddress')
        end

        it 'should generate valid content for bareos-sd.conf' do
          content = catalogue.resource('file', '/etc/bareos/bareos-sd.conf').send(:parameters)[:content]
          expect(content).to match('storage-password-for-bareos')
          expect(content).to match('monitor-password-for-bareos')
          expect(content).to match('SDPort')
          expect(content).to match('SDAddress')
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
          expect(content).to match('/etc/bareos/conf.d/clients')
          expect(content).to match('/etc/bareos/conf.d/jobs')
        end

      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
