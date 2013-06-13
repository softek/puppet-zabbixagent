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
  $version = 'latest',
) {
  $servers_real = $servers ? {
    ''      => 'localhost',
    default => $servers,
  }
  $hostname_real = $hostname ? {
    ''      => $::fqdn,
    default => $hostname,
  }
  $config_dir = $::operatingsystem ? {
    /(debian|ubuntu|centos)/ => '/etc/zabbix',
    'windows'                => 'C:/ProgramData/Zabbix',
    default                  => undef
  }
  $config_file = "${config_dir}/zabbix_agentd.conf"
  $service_name = $::operatingsystem ? {
    /(debian|ubuntu|centos)/ => 'zabbix-agent',
    'windows'                => 'Zabbix Agent',
    default                  => undef
  }
  Package <| |> -> Ini_setting <| |>

  case $::operatingsystem {
    centos: {
      include epel

      package {'zabbix-agent' :
        ensure  => $version,
        require => Yumrepo["epel"]
      }
    }

    debian, ubuntu: {
      package {'zabbix-agent' :
        ensure  => $version
      }
    }

    windows: {
      $package_version = $version ? {
        /(latest|2\.0\..*)/ => '2.0.x',
        default             => '1.8.x',
      }
    }
  }

  case $::operatingsystem {
    debian, ubuntu, centos: {
      service { $service_name :
        ensure  => running,
        enable  => true,
        require => Package['zabbix-agent'],
      }
      
      zabbixagent::config { 'Server':
        ensure => present,
        value  => join(flatten([$servers_real]), ','),
      }

      zabbixagent::config { 'Hostname':
        ensure => present,
        value => $hostname_real,
      }

      zabbixagent::config { 'Include':
        ensure => present,
        value => '/etc/zabbix/zabbix_agentd/',
      }

      file { '/etc/zabbix/zabbix_agentd':
        ensure  => directory,
        require => Package['zabbix-agent'],
      }
    }
    windows: {
      $homedir = 'C:/Program Files/Zabbix/'

      file { $config_dir: ensure => directory }
      file { $config_file:
        ensure  => present,
        mode    => '0770',
      }
      
      zabbixagent::config { 'Server':
        ensure => present,
        value  => join(flatten([$servers_real]), ','),
      }

      zabbixagent::config { 'Hostname':
        ensure => present,
        value => $hostname_real,
      }

      file { $homedir:
        ensure  => directory,
        source  => "puppet:///modules/zabbixagent/win64/${version}",
        recurse => true,
        mode    => '0770',
      }

      exec { 'install Zabbix Agent':
        path    => $::path,
        cwd     => $homedir,
        command => "\"${homedir}/zabbix_agentd.exe\" --config ${config_file} --install",
        require => [File[$homedir], File[$config_file]],
        unless  => "sc query \"${service_name}\""
      }

      service { $service_name:
        ensure  => running,
        require => Exec['install Zabbix Agent'],
      }
    }
    default: { notice "Unsupported operatingsystem  ${::operatingsystem}" }
  }
}
