# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting = $::zabbixagent::params::ensure_setting,
) inherits ::zabbixagent::params {
  case $::kernel {
    Linux: {
      package { 'zabbix-agent':
        ensure => $ensure_setting,
        notify => Service['zabbix-agent'],
      }
    } # end Linux
    
    Windows: {
      package { 'zabbix-agent':
        ensure   => $ensure_setting,
        provider => 'chocolatey',
        notify   => Service['zabbix-agent'],
      }
    } # end Windows
    
    default: {
      fail($::zabbixagent::params::fail_message)
    }
  }
}
