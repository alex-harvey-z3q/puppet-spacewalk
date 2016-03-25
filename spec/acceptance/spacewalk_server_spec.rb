require 'spec_helper_acceptance'

describe 'configuring spacewalk' do
  context 'puppet apply' do
    it 'should apply and be idempotent' do
      pp = <<-EOS
include spacewalk::server
EOS
      apply_manifest pp, :catch_failures => true
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

  context 'ports' do
    describe port('80') do
      it { should be_listening }
    end
    describe port('443') do
      it { should be_listening }
    end
  end
end
