class zabbixagent() {

  package {'zabbix-agent' :
    ensure  => installed,
  }

  service {'zabbix-agent' :
    ensure  => running,
    enable  => true,
    require => Package['zabbix-agent'],
  }

  file {'/etc/zabbix/zabbix_agentd.conf' :
    content => template('zabbixagent/zabbix_agentd.conf.unix.erb'),
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }
}
