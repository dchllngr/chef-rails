#
# Cookbook Name:: rails
# Attributes:: rbenv
#
# Copyright (C) 2013 Alexander Merkulov
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rails']['apps_base_path']      = '/srv/apps'
default['rails']['sites_base_path']      = '/srv/sites'
default['rails']['apps']      = {
  # "default" => {
  #   "name" => "rails",
  #   "user" => "merkulov",
  #   "folders" => [],
  #   "rbenv" => {
  #     "version"=> "2.0.0-p247",
  #     "gems"=> ["bundler"]   
  #   } 
  # }
}
default['rails']['sites'] = {}
default['rails']['user']['deploy']      = 'deploy'
default['vagrant']['fqdn'] = "merq.dev"
default["rails"]["databases"] = []