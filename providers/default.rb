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

action :nothing do
end

action :backup do
  converge_by 'duply backup' do
    duply_command_as_user(new_resource.user,
                          new_resource.profile, 'backup')
  end
end

action :full do
  converge_by 'duply full' do
    duply_command_as_user(new_resource.user,
                          new_resource.profile,
                          'full')
  end
end

action :incremental do
  converge_by 'duply incr' do
    duply_command_as_user(new_resource.user,
                          new_resource.profile,
                          'incr')
  end
end

action :restore do
  converge_by 'duply restore' do
    duply_command_as_user(new_resource.user,
                          new_resource.profile,
                          'restore',
                          [new_resource.destination])
  end
end

private

def duply_command_as_user(user, profile, command, args = [])
  # We actually use su command as root to fully run as the specified user
  # along with all its environment variables, etc.  This is required so that pre and post
  # are in the right environment.
  execute "duply_#{profile}_#{command}" do
    command "su - #{user} -c \"/usr/bin/flock -n /var/run/duply.lock /usr/bin/duply #{profile} #{command} #{args.flatten.join ' '}\";sleep 1"
    user 'root'
    group 'root'
  end
end
