require 'spec_helper_acceptance'

describe 'spacewalk::server' do
  let(:manifest) {
    <<-EOS
class { 'spacewalk::server':
  manage_repos => true,
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

  describe port('80') do
    it { is_expected.to be_listening }
  end

  describe port('443') do
    it { is_expected.to be_listening }
  end
end
