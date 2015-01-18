# Manages configuration of the Zabbix agent and associated repos (if enabled)
class zabbixagent::config (
  $config_dir     = $::zabbixagent::config_dir,
  $hostname       = $::zabbixagent::params::hostname,
  $include_dir    = $::zabbixagent::params::include_dir,
  $include_file   = $::zabbixagent::params::include_file,
  $logfile        = $::zabbixagent::params::logfile,
  $servers        = $::zabbixagent::params::servers,
  $servers_active = $::zabbixagent::params::servers,
) inherits ::zabbixagent::params {
  

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
  
  file { "${config_dir}/zabbix_agentd.d":
    ensure => 'directory',
  }

  if ($include_file == '') {
    ini_setting { 'include setting':
      ensure  => absent,
      path    => "${config_dir}/zabbix_agentd.conf",
      section => '',
      setting => 'Include',
      notify  => Service['zabbix-agent'],
    }
    
  } else {
    $include_value = "${config_dir}\\${include_dir}\\${include_file}"
    
    file { "${config_dir}/${include_dir}":
      ensure => directory,
    }
    
    file { "${config_dir}/${include_dir}/${include_file}":
      ensure  => file,
      require => File["${config_dir}/${include_dir}"],
    }
    
    ini_setting { 'include setting':
      ensure  => present,
      path    => "${config_dir}/zabbix_agentd.conf",
      section => '',
      setting => 'Include',
      value   => $include_value,
      notify  => Service['zabbix-agent'],
    }
    
  } # end if / else for $include_file
  
  ini_setting { 'logfile setting':
    ensure  => present,
    path    => "${config_dir}/zabbix_agentd.conf",
    section => '',
    setting => 'LogFile',
    value   => $logfile,
    notify  => Service['zabbix-agent'],
  }
  
}
