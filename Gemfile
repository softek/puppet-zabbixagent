# vim:ft=ruby
source ENV['GEM_SOURCE'] || "https://rubygems.org"

if ENV.key?('PUPPET_VERSION')
  puppetversion = "= #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.7.3', '< 4.0']
end

group :development, :unit_tests do
  gem 'puppet',                  puppetversion
  gem 'puppet-lint',             ['>= 1.0.0', '< 1.1.0']
  gem 'puppetlabs_spec_helper',  '~> 0.8'
  gem 'rspec-puppet',            :git => 'https://github.com/rodjek/rspec-puppet.git'
end


