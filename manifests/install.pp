# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting = $::zabbixagent::params::ensure_setting,
) inherits ::zabbixagent::params {
  case $::kernel {
    Linux: {
      package { 'zabbix-agent':
        ensure => $ensure_setting,
      }
    } # end Linux
    
    Windows: {
      package { 'zabbix-agent':
        ensure   => $ensure_setting,
        provider => 'chocolatey',
      }
    } # end Windows
    
    default: {
      fail($::zabbixagent::params::fail_message)
    }
  }
}
