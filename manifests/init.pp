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
class softek-zabbixagent(
  $servers = '',
  $servers_active = '',
  $hostname = '',
){
  $servers_real = $servers ? {
    ''      => 'localhost',
    default => $servers,
  }
  $servers_active_real = $servers_active ? {
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

      ini_setting { 'servers setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'Server',
        value   => join(flatten([$servers_real]), ','),
        require => Package['zabbix-agent'],
      }

      ini_setting { 'active servers setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'ServerActive',
        value   => join(flatten([$servers_active_real]), ','),
        require => Package['zabbix-agent'],
      }

      ini_setting { 'hostname setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'Hostname',
        value   => $hostname_real,
        require => Package['zabbix-agent'],
      }
    }
   Amazon: {
      package { "zabbix-release":
        provider => rpm,
        ensure => installed,
        source => "http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm",
        before => Package['zabbix-agent'],
      }
      package {'zabbix-agent' :
        ensure  => installed,
      }

      service {'zabbix-agent' :
        ensure  => running,
        enable  => true,
        require => Package['zabbix-agent'],
      }

      ini_setting { 'servers setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'Server',
        value   => join(flatten([$servers_real]), ','),
        require => Package['zabbix-agent'],
      }

      ini_setting { 'active servers setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'ServerActive',
        value   => join(flatten([$servers_active_real]), ','),
        require => Package['zabbix-agent'],
      }

      ini_setting { 'hostname setting':
        ensure  => present,
        path    => '/etc/zabbix/zabbix_agentd.conf',
        section => '',
        setting => 'Hostname',
        value   => $hostname_real,
        require => Package['zabbix-agent'],
      }
    }
    windows: {
      $confdir = 'C:/ProgramData/Zabbix'
      $homedir = 'C:/Program Files/Zabbix/'

      file { $confdir: ensure => directory }
      file { "${confdir}/zabbix_agentd.conf":
        ensure  => present,
        mode    => '0770',
      }

      ini_setting { 'servers setting':
        ensure  => present,
        path    => "${confdir}/zabbix_agentd.conf",
        section => '',
        setting => 'Server',
        value   => join(flatten([$servers_real]), ','),
        require => File["${confdir}/zabbix_agentd.conf"],
      }

      ini_setting { 'hostname setting':
        ensure  => present,
        path    => "${confdir}/zabbix_agentd.conf",
        section => '',
        setting => 'Hostname',
        value   => $hostname_real,
        require => File["${confdir}/zabbix_agentd.conf"],
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

