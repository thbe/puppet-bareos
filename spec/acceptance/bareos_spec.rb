require 'spec_helper_acceptance'

describe 'bareos' do
  let(:manifest) {
    <<-EOS
class { 'bareos':
  type_dir => true,
  client_password => 'Start123!',
  monitor_password => 'Start123!',
  storage_password => 'Start123!',
  storage_daemon => 'bac-sd.example.local',
  mail_hub => 'mail.example.local',
  mail_group => 'bac-group@example.local',
  backup_clients => [ 'client1.example.local', 'client2.example.local' ]
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
end
