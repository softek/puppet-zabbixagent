# Makes sure the service is running
class zabbixagent::service {
  $service_name = $::kernel ? {
    'Windows' => 'Zabbix Agent',
    default   => 'zabbix-agent',
  }
  
  service { 'zabbix-agent':
    ensure  => running,
    name    => $service_name,
    enable  => true,
    require => Package['zabbix-agent'],
  }
}
