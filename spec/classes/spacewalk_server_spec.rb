require 'spec_helper'

describe 'spacewalk::server' do
  it { is_expected.to compile.with_all_deps }
end
