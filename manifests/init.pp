# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Parameters: 
#   $ensure_setting     Passed directly to ensure of package resource
#                       Default: 'present'
#
#   $hostname           The hostname used in the config file.
#                       Default: $::fqdn
#
#   $manage_repo_epel   Determines if the EPEL repo is managed on the RedHat
#                       family of OS's.
#                       Default: false
#                       Type: boolean
#
#   $manage_repo_zabbix Determines if the Zabbix repo is managed on the RedHat
#                       family of OS's.
#                       Default: false
#                       Type: boolean
#
#   $servers            The server or servers used in the Servers setting.
#                       Default: '127.0.0.1'
#                       Type: String separated by commas OR Array
#
#   $servers_active     The server or servers used in the Servers setting.
#                       Default: '127.0.0.1'
#                       Type: String separated by commas OR Array
#
# Actions:
#
# Requires: see metadata.json
#
# Sample Usage:
#
class zabbixagent (
  $ensure_setting     = $::zabbixagent::params::ensure,
  $hostname           = $::zabbixagent::params::hostname,
  $manage_repo_epel   = $::zabbixagent::params::manage_repo_epel,
  $manage_repo_zabbix = $::zabbixagent::params::manage_repo_zabbix,
  $servers            = $::zabbixagent::params::servers,
  $servers_active     = $::zabbixagent::params::servers,
) inherits ::zabbixagent::params {
  class { '::zabbixagent::preinstall':
    manage_repo_epel   => $manage_repo_epel,
    manage_repo_zabbix => $manage_repo_zabbix,
    
  } ->
  
  class { '::zabbixagent::install':
    ensure_setting => $ensure_setting,
  } ->
  
  class { '::zabbixagent::config':
    hostname       => $hostname,
    servers        => $servers,
    servers_active => $servers_active,
  } ->
  
  class { '::zabbixagent::service': }
  
}
