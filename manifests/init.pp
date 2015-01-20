# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Parameters: 
#   $ensure_setting     Passed directly to ensure of package resource
#                       Default: 'present'
#
#   $hostname           The hostname used in the config file.
#                       Default: downcase($::fqdn)
#
#   $include_dir        The directory that additional config files will be
#                       placed in.
#                       Default: 'zabbix_agentd.d'
#                       Type: String
#
#   $include_file       A file that that contain additional settings
#                       Default: ''
#                       Type: String
#
#   $logfile            The full path to where Zabbix should store it's logs.
#                       Default: 'C:\zabbix_agentd.log'
#                       Type: String
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
#
# Actions:
#
# Requires: see metadata.json
#
# Sample Usage:
#
class zabbixagent (
  $ensure_setting     = $::zabbixagent::params::ensure_setting,
  $hostname           = $::zabbixagent::params::hostname,
  $include_dir        = $::zabbixagent::params::include_dir,
  $include_file       = $::zabbixagent::params::include_file,
  $logfile            = $::zabbixagent::params::logfile,
  $manage_repo_epel   = $::zabbixagent::params::manage_repo_epel,
  $manage_repo_zabbix = $::zabbixagent::params::manage_repo_zabbix,
  $servers            = $::zabbixagent::params::servers,
  $servers_active     = $::zabbixagent::params::servers_active,
) inherits ::zabbixagent::params {
  
  # validate booleans
  validate_bool($manage_repo_epel)
  validate_bool($manage_repo_zabbix)
  
  # validate strings
  validate_string($ensure_setting)
  validate_string($hostname)
  validate_string($include_dir)
  validate_string($include_file)
  validate_string($logfile)
  validate_string($servers)
  validate_string($servers_active)
  
  class { '::zabbixagent::preinstall':
    manage_repo_epel   => $manage_repo_epel,
    manage_repo_zabbix => $manage_repo_zabbix,
    
  } ->
  
  class { '::zabbixagent::install':
    ensure_setting => $ensure_setting,
  } ->
  
  class { '::zabbixagent::config':
    hostname       => $hostname,
    include_dir    => $include_dir,
    include_file   => $include_file,
    logfile        => $logfile,
    servers        => $servers,
    servers_active => $servers_active,
  } ->
  
  class { '::zabbixagent::service': }
  
}
