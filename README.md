duply cookbook
==============
[![Build Status](https://travis-ci.org/datacoda/chef-duply.svg?branch=master)](https://travis-ci.org/datacoda/chef-duply)
[![Cookbook Version](https://img.shields.io/cookbook/v/duply.svg)](https://supermarket.chef.io/cookbooks/duply)

LWRP for Duplicity/Duply backup sets.

Supports

* Ubuntu 12.04
* Ubuntu 14.04
* Debian 7.4


Requirements
------------

Duplicity installed.


Usage
-----

Attributes
----------

Recipes
-------

### default
Installs the LWRP.  Does nothing else.


Resources
---------
This cookbook provides a profile resource along with direct command execution.

```ruby
duply_profile "profile_name" do
  destination "file:///var/backups/test"
  encrypt_for [ keys['server'][:key_id], keys['alice'][:key_id], keys['bob'][:key_id] ]
  signed_by   keys['server'][:key_id]
  passphrase  keys['server'][:passphrase]
  compression :bzip2
  volume_size 50
  keep_full   5
  full_every  '2M'
  includes [
      '/etc/duply'
  ]
  excludes [
      '**.asc'
  ]
end
```

It is also possible to use Swift (OpenStack) as storage backend and to choose traditional symmetric GPG encryption only.

```ruby
duply_profile 'swift' do
  destination 'swift://backup'
  passphrase 'testpass'
  swift_username 'swift_user123'
  swift_tenant 'swift_tenant123'
  swift_password 'swift_password123'
  swift_authurl 'https:/swift.example.com:5000/v2.0'
  includes [
      '/etc/duply'
  ]
  excludes [
      '**.asc'
  ]
end
```

Execute duply commands from the cookbook

```ruby
duply "test-incr" do
  profile "test"
  action :incremental
end
```



License & Authors
-----------------
- Author:: Li-Te Chen (<datacoda@gmail.com>)
- Author:: Gunter Miegel (<gunter.miegel@rgsqd.de>, <gunter.miegel@cloudandheat.com>)

```text
Copyright 2014-2016 Nephila Graphic, Li-Te Chen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
