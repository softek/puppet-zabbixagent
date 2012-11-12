# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class zabbixagent() {

  package {'zabbix-agent' :
    ensure  => installed,
  }

  service {'zabbix-agent' :
    ensure  => running,
    enable  => true,
    require => Package['zabbix-agent'],
  }

  class {'zabbixagent::config' :
    content => template('zabbixagent/zabbix_agentd.conf.unix.erb'),
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }
}
