# Makes sure the service is running
class zabbixagent::service {
  service { 'zabbix-agent':
    ensure  => running,
    enable  => true,
    require => Package['zabbix-agent'],
  }
}
