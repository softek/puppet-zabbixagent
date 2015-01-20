[![Build Status][travis-img-master]][travis-ci]
[![Puppet Forge][pf-img]][pf-link]
[![GitHub tag][gh-tag-img]][gh-link]

# Zabbix Agent Puppet Module

#### Table of Contents

1. [Overview](#overview)
2. [Setup requirements](#setup-requirements)
3. [Parameters](#parameters)
4. [Limitations](#limitations)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [Contributors](#contributors)
8. [License](#license)

## Overview

This module manages the zabbix agent for a monitored machine. It can
also, optionally, manage repositories related to Zabbix on Linux. On the Red Hat
family of OS's, this includes both EPEL and Zabbix. On the Debian family,
this is just the Zabbix repo.  On Windows this module utilizes the
[Chocolatey](chocolatey.org) provider.

## Setup Requirements

This module has been tested against Puppet 3.7.3 on:
* CentOS 6.6
* Ubuntu Server 14.04
* Windows 7
* Windows Server 2012 R2


## Parameters:

##### `ensure_setting`  
Passed directly to ensure of package resource  
Default: `'present'`

##### `hostname`  
The hostname used in the config file.  
Default: `downcase($::fqdn)`

##### `include_dir`  
The directory that additional config files will be placed in.  
Default: `'zabbix_agentd.d'`  
Type: String

##### `include_file`  
A file that that contain additional settings  
Default: `''`  
Type: String

##### `logfile`  
The full path to where Zabbix should store it's logs.  
Default: `'C:\zabbix_agentd.log'`  
Type: String

##### `manage_repo_epel`  
Determines if the EPEL repo is managed on the RedHat family of OS's.  
Default: `false`  
Type: boolean

##### `manage_repo_zabbix`  
Determines if the Zabbix repo is managed on the RedHat family of OS's.  
Default: `false`  
Type: boolean

##### `servers`  
The server or servers used in the Servers setting.  
Default: `'127.0.0.1'`  
Type: String separated by commas OR Array

##### `servers_active`  
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

## Contributing

Pull requests, bug reports, and enancement requrest are welcome! Enhancement
requests should be file just like other issues.

## Contributors

* Scott Smerchek (@smerchek) - Author of [softek-zabbixagent][pf-softek-zabbixagent]
* Martijn Storck (@martijn)  - Added CentOS support

## License

This is released under the New BSD / BSD 3 Clause license. A copy of the license
can be found in the root of the module.

### History

This was originally [softek-zabbixagent][pf-softek-zabbixagent] before undergoing
a total rewrite in January 2015. Post rewrite, only a couple of comments and part of
one line of the original code was left. Since no 'substantial portions' of the code
was reused and no written licence was contained in the repository I have chosen not
to reuse the MIT license that was referenced in the original metadata.json file.

This module has been released independant of the origial after reviewing the
original author's GitHub issue tracker. Specificaly, it appeared that they had
not been responding to issues or pull requests for at least six months and some
had sat for nearly two years. This response timeframe and my needs didn't line
up so here we are.

[coveralls-master]: https://coveralls.io/r/genebean/genebean-zabbixagent?branch=master
[coveralls-img-master]: https://img.shields.io/coveralls/genebean/genebean-zabbixagent/master.svg
[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-zabbixagent.svg
[gh-link]: https://github.com/genebean/genebean-zabbixagent
[pf-img]: https://img.shields.io/puppetforge/v/genebean/zabbixagent.svg
[pf-link]: https://forge.puppetlabs.com/genebean/zabbixagent
[pf-softek-zabbixagent]: https://forge.puppetlabs.com/softek/zabbixagent
[travis-ci]: https://travis-ci.org/genebean/genebean-zabbixagent
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-zabbixagent/master.svg
