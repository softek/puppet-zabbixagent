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
          notify  => Exec['yum clean all'],
        }
    
        file { '/etc/yum.repos.d/epel-testing.repo':
          ensure  => file,
          content => template('zabbixagent/epel-testing.repo.erb'),
          notify  => Exec['yum clean all'],
        }
      }
    
      # Zabbix
      if ($manage_repo_zabbix) {
        file { '/etc/yum.repos.d/zabbix.repo':
          ensure  => file,
          content => template('zabbixagent/zabbix.repo.erb'),
          notify  => Exec['yum clean all'],
        }
      }
    } # end RedHat
    
    Debian: {
      case $::operatingsystem {
        Ubuntu: {
          # Zabbix
          if ($manage_repo_zabbix) {
            file { '/etc/apt/sources.list.d/zabbix.list':
              ensure  => file,
              content => template('zabbixagent/zabbix.list.erb'),
              notify  => Exec['apt-get update'],
            }
            
          }
          
        } # end Ubuntu
        
        default: {
        }
        
      } # end case $::operatingsystem
      
    } # end Debian
    
    default: {
    }
    
  } # end case $::osfamily
  
  exec { 'yum clean all':
    path        => '/usr/bin',
    user        => 'root',
    logoutput   => true,
    refreshonly => true,
    command     => 'yum clean all',
  }
  
  exec { 'apt-get update':
    path        => '/usr/bin',
    user        => 'root',
    logoutput   => true,
    refreshonly => true,
    command     => 'apt-get update',
  }
  
} # end class
