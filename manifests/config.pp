# Manages configuration of the Zabbix agent and associated repos (if enabled)
class zabbixagent::config (
  $hostname       = $::zabbixagent::params::hostname,
  $servers        = $::zabbixagent::params::servers,
  $servers_active = $::zabbixagent::params::servers,
) inherits ::zabbixagent::params {
  case $::kernel {
    'Linux'   : {
      $config_dir  = '/etc/zabbix'
    }

    'Windows' : {
      $config_dir  = 'C:/Program Files/Zabbix Agent'
    }

    default   : {
      fail($::zabbixagent::params::fail_message)
    }
  }
  
  file { "${config_dir}/åzabbix_agentd.d":
    ensure => 'directory',
  }

  ini_setting { 'servers setting':
    ensure  => present,
    path    => "${config_dir}/zabbix_agentd.conf",
    section => '',
    setting => 'Server',
    value   => join(flatten([$servers]), ','),
    notify  => Service['zabbix-agent'],
  }

  ini_setting { 'servers active setting':
    ensure  => present,
    path    => "${config_dir}/zabbix_agentd.conf",
    section => '',
    setting => 'ServerActive',
    value   => join(flatten([$servers_active]), ','),
    notify  => Service['zabbix-agent'],
  }

  ini_setting { 'hostname setting':
    ensure  => present,
    path    => "${config_dir}/zabbix_agentd.conf",
    section => '',
    setting => 'Hostname',
    value   => $hostname,
    notify  => Service['zabbix-agent'],
  }

  ini_setting { 'include setting':
    ensure  => present,
    path    => "${config_dir}/zabbix_agentd.conf",
    section => '',
    setting => 'Include',
    value   => "${config_dir}/åzabbix_agentd.d",
    notify  => Service['zabbix-agent'],
  }
}
