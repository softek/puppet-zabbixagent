2013-02-18 Release 1.0.0
Breaking Changes:
- Default hostname is now `$::fqdn` instead of `$::hostname`

Changes:
- Added CentOS support (by @martijn)

Bugfixes:
- Added restarting of the zabbix-agent service when a setting is changed (#3)
- Fix dependency issues between package, service, and ini_settings (#4)

2013-01-02 Release 0.1.0
Changes:
- Use ini_setting module to only change necessary settings rather than use
the entire config file as a template. This will insulate us from changes in the 
Zabbix configuration with new versions.
- Other fixes