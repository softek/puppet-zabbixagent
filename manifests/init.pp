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
class zabbixagent(
  $servers = '',
  $hostname = '',
) {
  $servers_real = $servers ? {
    ''      => 'localhost',
    default => $servers,
  }
  $hostname_real = $hostname ? {
    ''      => $::hostname,
    default => $hostname,
  }

  case $::operatingsystem {
    debian, ubuntu: {
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
    windows: {
      $confdir = 'C:/ProgramData/Zabbix'
      $homedir = 'C:/Program Files/Zabbix/'

      file { $confdir: ensure => directory }
      file { "${confdir}/zabbix_agentd.conf":
        content => template('zabbixagent/zabbix_agentd.conf.windows.erb'),
        mode    => '0770',
      }
      file { $homedir:
        ensure  => directory,
        source  => 'puppet:///modules/zabbixagent/win64',
        recurse => true,
        mode    => '0770',
      }

      exec { 'install Zabbix Agent':
        path    => $::path,
        cwd     => $homedir,
        command => "\"${homedir}/zabbix_agentd.exe\" --config ${confdir}/zabbix_agentd.conf --install",
        require => [File[$homedir], File["${confdir}/zabbix_agentd.conf"]],
        unless  => 'sc query "Zabbix Agent"'
      }

      service { 'Zabbix Agent':
        ensure  => running,
        require => Exec['install Zabbix Agent'],
      }
    }
    default: { notice "Unsupported operatingsystem  ${::operatingsystem}" }
  }
}
