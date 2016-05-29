require 'spec_helper'

describe 'spacewalk::server' do
  context 'with defaults' do
    it { is_expected.to compile.with_all_deps }
  end

  context 'manage_repos => true' do
    let(:params) {{
      :manage_repos => true,
    }}
    it { is_expected.to compile.with_all_deps }
  end
end
