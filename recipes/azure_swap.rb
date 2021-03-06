#
# Cookbook Name:: rails
# Definition:: azure_swap
#
# Copyright (C) 2017 Alexander Merkulov
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

if node['rails']['azure']['swap']
  include_recipe 'rails::waagent'
  swap_file "#{node['rails']['mnt']}/swapfile" do
    size      node['rails']['swap']['size'].to_i # MBs
    persist   true
    only_if { node['rails']['swap']['enable'] }
    only_if { File.exist?(node['rails']['mnt']) }
  end
end
