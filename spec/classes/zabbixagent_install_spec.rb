require 'spec_helper'

describe 'zabbixagent::install' do

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

      }
    }

    # Make sure package will be installed.
    it { should contain_package('zabbix-agent').with_ensure('present') }
    it { should contain_package('zabbix-agent').with_name('zabbix-agent') }

  end
end