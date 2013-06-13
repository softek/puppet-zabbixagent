# Class: zabbixagent::config
#
# This class updates the zabbix agent configuration file
#
define zabbixagent::config($value, $ensure = 'present') {
  ini_setting { 'servers setting':
    ensure  => $ensure,
    path    => $zabbixagent::config_file,
    section => '',
    setting => $name,
    value   => $value,
    notify  => Service[$zabbixagent::service_name],
  }
}
