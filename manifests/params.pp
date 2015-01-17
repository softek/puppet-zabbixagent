# Parameters used by this module
class zabbixagent::params {
  $ensure_setting     = 'present'
  $hostname           = $::fqdn
  $manage_repo_epel   = false
  $manage_repo_zabbix = false
  $servers            = '127.0.0.1'
  $servers_active     = '127.0.0.1'

  # this isn't a parameter but, since this class is inherited by all classes
  # it is a good place to put this message so that it's the same everywhere
  $fail_message       = "${::kernel} is not yet supported by this module."
}
