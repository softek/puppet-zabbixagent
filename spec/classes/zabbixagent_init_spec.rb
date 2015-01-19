require 'spec_helper'

describe 'zabbixagent' do

  # Running an RedHat OS.
  context 'On a RedHat OS with repo management enabled' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'RedHat',
          :operatingsystem => 'RedHat'
      }
    end

    let(:params) {
      {
          :manage_repo_epel   => true,
          :manage_repo_zabbix => true
      }
    }

    # Check that all classes are present
    it { should contain_class('zabbixagent::params')}
    it { should contain_class('zabbixagent::preinstall')}
    it { should contain_class('zabbixagent::install')}
    it { should contain_class('zabbixagent::config')}
    it { should contain_class('zabbixagent::service')}

  end
end