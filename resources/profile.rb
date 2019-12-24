#
# Cookbook Name:: duply
# Resource:: profile
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

actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true

attribute :destination, kind_of: String, required: true
attribute :user, kind_of: String, default: nil
attribute :password, kind_of: String, default: nil
attribute :includes, kind_of: Array, default: []
attribute :excludes, kind_of: Array, default: []

attribute :max_age, kind_of: String, default: '1M'

attribute :keep_full, kind_of: [Integer, NilClass]
attribute :full_every, kind_of: [String, NilClass]

attribute :encrypt_for, kind_of: [String, Array]
attribute :signed_by, kind_of: String
attribute :passphrase, kind_of: String
attribute :passphrase_sign, kind_of: String
attribute :compression,
          kind_of: Symbol,
          equal_to: %i[bzip2 incremental none],
          default: :none

attribute :volume_size, kind_of: Integer, default: 25
attribute :temp_dir, kind_of: String, default: '/tmp'
attribute :arch_dir, kind_of: String, default: nil

attribute :template, kind_of: String, default: 'conf.erb'
attribute :cookbook, kind_of: String, default: 'duply'

attribute :pre_template, kind_of: String, default: 'pre.erb'
attribute :pre_cookbook, kind_of: String, default: 'duply'

attribute :post_template, kind_of: String, default: 'post.erb'
attribute :post_cookbook, kind_of: String, default: 'duply'

attribute :swift_username, kind_of: String, default: nil
attribute :swift_tenant, kind_of: String, default: nil
attribute :swift_password, kind_of: String, default: nil
attribute :swift_authurl, kind_of: String, default: nil
attribute :swift_authversion, kind_of: Integer, default: 2

def initialize(*args)
  super
end
