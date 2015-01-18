# Parameters used by this module
class zabbixagent::params {
  $ensure_setting     = 'present'
  $hostname           = downcase($::fqdn)
  $include_dir        = 'zabbix_agentd.d'
  $include_file       = ''
  $manage_repo_epel   = false
  $manage_repo_zabbix = false
  $servers            = '127.0.0.1'
  $servers_active     = '127.0.0.1'

  # this isn't a parameter but, since this class is inherited by all classes
  # it is a good place to put this message so that it's the same everywhere
  $fail_message       = "${::kernel} is not yet supported by this module."
  
  case $::kernel {
    'Linux'   : {
      $config_dir = '/etc/zabbix'
      $logfile    = '/var/log/zabbix/zabbix_agentd.log'
    }

    'Windows' : {
      $config_dir = 'C:/Program Files/Zabbix Agent'
      $logfile    = 'C:/zabbix_agentd.log'
    }

    default   : {
      fail($fail_message)
    }
    
  } #end case
  
}
