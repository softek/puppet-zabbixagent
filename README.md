# Zabbix Agent Puppet Module
This module manages the zabbix agent for a monitored machine.

This module has been tested against Puppet 3.0.1 on Windows Server 2008R2 and Ubuntu Server 12.04.

### Authors
* Scott Smerchek <scott.smerchek@softekinc.com>

## Usage

```puppet
class { 'zabbixagent':
  servers  => 'zabbix.example.com', # Optional: defaults to localhost (accepts an array)
  hostname => 'web01.example.com' # Optional: defaults to the hostname of the machine
}
```

This is the only configuration supported at this time. Custom user parameters may
come at a later date. If there is any other configuration that ought to be made available,
then please let me know.