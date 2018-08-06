require 'spec_helper'

describe "Clickhouse Setup" do
  describe package('clickhouse-server') do
    it { should be_installed }
  end

  describe file('/etc/clickhouse-server/config.xml') do
    its(:content) { should include("<path>#{ANSIBLE_VARS.fetch('clickhouse_path_data', 'FAIL')}</path>") }
  end
end
