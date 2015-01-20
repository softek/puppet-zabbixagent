require 'spec_helper'

describe 'zabbixagent::preinstall' do

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

  end
end