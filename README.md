# Zabbix Agent Puppet Module
This module manages the zabbix agent for a monitored machine.

This module has been tested against Puppet 3.7.3 on Windows 7, Windows Server 2012R2,
Ubuntu Server 12.04, and CentOS 6.6.


## Parameters:

### `ensure_setting`  
Passed directly to ensure of package resource  
Default: `'present'`

### `hostname`  
The hostname used in the config file.  
Default: `downcase($::fqdn)`

### `include_dir`  
The directory that additional config files will be placed in.  
Default: `'zabbix_agentd.d'`  
Type: String

### `include_file`  
A file that that contain additional settings  
Default: `''`  
Type: String

### `logfile`  
The full path to where Zabbix should store it's logs.  
Default: `'C:\zabbix_agentd.log'`  
Type: String

### `manage_repo_epel`  
Determines if the EPEL repo is managed on the RedHat family of OS's.  
Default: `false`  
Type: boolean

### `manage_repo_zabbix`  
Determines if the Zabbix repo is managed on the RedHat family of OS's.  
Default: `false`  
Type: boolean

### `servers`  
The server or servers used in the Servers setting.  
Default: `'127.0.0.1'`  
Type: String separated by commas OR Array

### `servers_active`  
The server or servers used in the Servers setting.  
Default: `'127.0.0.1'`  
Type: String separated by commas OR Array


## Usage

```puppet
class { 'zabbixagent':
  ensure_setting => 'latest',
  include_file   => 'userparams.conf',
  servers        => 'zabbix.example.com',
  servers_active => 'zabbix.example.com',
}
```

The list of params above is the only configuration supported at this time but a
fully parameterized `zabbix_agentd.conf` will be coming soon.

## History
This was originally [softek-zabbixagent][pf-softek-zabbixagent] before undergoing
a total rewrite in January 2015. After reviewing the original author's GitHub
it seemed that they have not been responding to issues or pull requests so I
decided to release my own module instead.

### Contributors
* Scott Smerchek (@smerchek) - Author of [softek-zabbixagent][pf-softek-zabbixagent]
* Martijn Storck (@martijn)  - Added CentOS support

[pf-softek-zabbixagent]: https://forge.puppetlabs.com/softek/zabbixagent
