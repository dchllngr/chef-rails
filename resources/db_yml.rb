#
# Cookbook Name:: rails
# Resource:: db_yml
#
# Copyright (C) 2013 Alexander Merkulov
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

actions :create

default_action :create

attribute :name, name_attribute: true, kind_of: String
attribute :host, kind_of: String, default: 'localhost' # Database Host
attribute :port, kind_of: String, default: '3306' # Database Port
attribute :socket, kind_of: String, default: '' # Database Socket
attribute :pool, kind_of: Integer, default: nil # Database Pool
attribute :type, kind_of: String, default: 'mysql' # Database Type
attribute :database_name, kind_of: String, default: nil # Database Name
attribute :database_user, kind_of: String, default: nil, required: true # User Name
attribute :database_password, kind_of: String, default: nil, required: true # Password
attribute :owner, kind_of: String, default: 'root' # Owner
attribute :group, kind_of: String, default: 'root' # Group
attribute :path, kind_of: String, default: '/root' # Path
attribute :cookbook, kind_of: String, default: 'rails' # Cookbook to find template
attribute :template, kind_of: String, default: 'database.yml.erb' # Template to use.
