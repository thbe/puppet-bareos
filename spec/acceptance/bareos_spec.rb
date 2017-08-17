require 'spec_helper_acceptance'

describe 'bareos' do
  let(:manifest) {
    <<-EOS
class { 'bareos':
  type_dir       => true,
  type_fd        => true,
  type_sd        => true,
  type_webui     => true,
  backup_clients => [ 'client1.example.local', 'client2.example.local' ],
}
EOS
  }

  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end

  it 'should apply a second time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end

  describe port(80) do
    it { should be_listening }
  end

  describe file('/etc/bareos/bareos-dir.d/clients/client1.example.local.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/etc/bareos/bareos-dir.d/clients/client2.example.local.conf') do
    it { should be_file }
    it { should exist }
  end

  if os[:family] == 'debian'
    describe package('mysql-server') do
      it { should be_installed }
    end

    describe package('apache2') do
      it { should be_installed }
    end

    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end

    if os[:release] == '7'
      describe service('bareos-director') do
        it { should be_running }
      end

      describe service('bareos-fd') do
        it { should be_running }
      end

      describe service('bareos-sd') do
        it { should be_running }
      end
    end

    if os[:release] == '8'
      describe service('bareos-dir') do
        it { should be_running }
      end

      describe service('bareos-filedaemon') do
        it { should be_running }
      end

      describe service('bareos-storage') do
        it { should be_running }
      end
    end
  end

  if os[:family] == 'redhat'
    describe package('mariadb') do
      it { should be_installed }
    end

    describe package('httpd') do
      it { should be_installed }
    end

    describe service('httpd') do
      it { should be_enabled }
      it { should be_running }
    end

    describe service('bareos-dir') do
      it { should be_running }
    end

    describe service('bareos-fd') do
      it { should be_running }
    end

    describe service('bareos-sd') do
      it { should be_running }
    end
  end
end
