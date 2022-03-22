require 'spec_helper'

describe "Clickhouse Setup" do
  describe package('clickhouse-server') do
    it { should be_installed }
  end

  describe file('/etc/clickhouse-server/config.d/dirs.xml') do
    its(:content) { should include("<path>#{ANSIBLE_VARS.fetch('clickhouse_path_data', 'FAIL')}</path>") }
  end

  describe file('/etc/clickhouse-server/users.d/users.xml') do
    its(:content) { should include("<users>") }
  end

  describe port(9000) do
    it { should be_listening }
  end

  describe port(9009) do
    it { should be_listening }
  end

  describe port(8123) do
    it { should be_listening }
  end

  describe command("clickhouse-client -h 127.0.0.1 -q 'show databases'") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /default/ }
  end
end
