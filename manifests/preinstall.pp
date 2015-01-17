# Repositories used by Zabbix
class zabbixagent::preinstall (
  $manage_repo_epel   = $::zabbixagent::params::manage_repo_epel,
  $manage_repo_zabbix = $::zabbixagent::params::manage_repo_zabbix,
) inherits ::zabbixagent::params {
  case $::osfamily {
    RedHat: {
      # EPEL
      if ($manage_repo_epel) {
        file { '/etc/yum.repos.d/epel.repo':
          ensure  => file,
          content => template('zabbixagent/epel.repo.erb'),
        }
    
        file { '/etc/yum.repos.d/epel-testing.repo':
          ensure  => file,
          content => template('zabbixagent/epel-testing.repo.erb'),
        }
      }
    
      # Zabbix
      if ($manage_repo_zabbix) {
        file { '/etc/yum.repos.d/zabbix.repo':
          ensure  => file,
          content => template('zabbixagent/zabbix.repo.erb'),
        }
      }
    } # end RedHat
    
    default: {
    }
  }
  
} # end class
