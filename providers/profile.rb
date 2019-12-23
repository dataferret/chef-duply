#
# Cookbook Name:: duply
# Provider:: profile
#
# Copyright 2014-2016 Nephila Graphic, Li-Te Chen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

use_inline_resources

action :delete do
  directory "#{node['duply']['dir']}/#{new_resource.name}" do
    action :delete
  end
end

action :create do
  directory "#{node['duply']['dir']}/#{new_resource.name}" do
    user 'root'
    group 'root'
    mode '0700'
    action :create
  end

  template "#{node['duply']['dir']}/#{new_resource.name}/conf" do
    cookbook new_resource.cookbook
    source new_resource.template
    owner 'root'
    group 'root'
    mode '0600'
    variables(
      gpg_keys_enc: [new_resource.encrypt_for].flatten,
      gpg_key_sign: new_resource.signed_by,
      gpg_pw: new_resource.passphrase,
      gpg_pw_sign: new_resource.passphrase_sign,
      target: new_resource.destination,
      target_user: new_resource.user,
      target_pass: new_resource.password,
      max_age: new_resource.max_age,
      max_full_backups: new_resource.keep_full,
      max_fullbkp_age: new_resource.full_every,
      volsize: new_resource.volume_size,
      arch_dir: new_resource.arch_dir,
      temp_dir: new_resource.temp_dir,
      swift_username: new_resource.swift_username,
      swift_tenant: new_resource.swift_tenant,
      swift_password: new_resource.swift_password,
      swift_authurl: new_resource.swift_authurl,
      swift_authversion: new_resource.swift_authversion
    )
    action :create
    sensitive true
  end

  # python-swifclient is not available in Ubuntu 12.04 and Debian 7.11
  package 'python-swiftclient' do
    action :install
    only_if { new_resource.swift_username.nil? }
    not_if { node['platform'].eql?('ubuntu') && node['platform_version'].eql?('12.04') }
    not_if { node['platform'].eql?('debian') && node['platform_version'].eql?('7.11') }
  end

  template "#{node['duply']['dir']}/#{new_resource.name}/exclude" do
    cookbook 'duply'
    source 'exclude.erb'
    owner 'root'
    group 'root'
    mode '0600'
    variables(
      includes: new_resource.includes,
      excludes: new_resource.excludes
    )
    action :create
  end

  template "#{node['duply']['dir']}/#{new_resource.name}/pre" do
    cookbook new_resource.pre_cookbook
    source new_resource.pre_template
    owner 'root'
    group 'root'
    mode '0600'
    action :create
    sensitive true
  end

  template "#{node['duply']['dir']}/#{new_resource.name}/post" do
    cookbook new_resource.post_cookbook
    source new_resource.post_template
    owner 'root'
    group 'root'
    mode '0600'
    action :create
    sensitive true
  end

  # new_resource.updated_by_last_action(tconf.updated_by_last_action? ||
  #                                     tpackage_swift.updated_by_last_action? ||
  #                                     texclude.updated_by_last_action? ||
  #                                     tpre.updated_by_last_action? ||
  #                                     tpost.updated_by_last_action?)
end
