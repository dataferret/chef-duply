name 'duply'
maintainer 'Li-Te Chen'
maintainer_email 'datacoda@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures duply'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.4'
chef_version '>=12'
source_url 'https://github.com/datacoda/chef-duply'
issues_url 'https://github.com/datacoda/chef-duply/issues'

%w[ubuntu debian].each do |os|
  supports os
end
