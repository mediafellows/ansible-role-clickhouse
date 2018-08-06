require 'spec_helper'

describe "Clickhouse Setup" do
  describe package('clickhouse-server') do
    it { should be_installed }
  end
end
