#
# Cookbook Name:: rails
# Attributes:: default
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

default['rails']['fqdn']            = true
default['rails']['swap']['size']    = '512' # MBs
default['rails']['swap']['enable']  = false
default['rails']['apps_base_path']  = '/srv/apps'
default['rails']['sites_base_path'] = '/srv/sites'
default['rails']['ports']           = %w( 22 )
default['rails']['ruby'] = false
default['rails']['cron'] = {
  minute: '*',
  hour: '*',
  day: '*',
  month: '*',
  weekday: '*',
  interval: nil,
  user: 'root',
  command: '',
  mailto: nil,
  path: nil,
  home: nil,
  shell: nil
}
default['rails']['apps'] = {
  # 'default2': {
  #   'db': [
  #     {
  #       'type': 'mongodb',
  #       'name': 'rails2',
  #       'user': 'rails2',
  #       'password': 'pass'
  #     },
  #     {
  #       'type': 'mongodb',
  #       'name': 'rails3',
  #       'user': 'rails3',
  #       'password': 'pass'
  #     },
  #     {
  #       'type': 'postgresql',
  #       'name': 'rails2',
  #       'user': 'rails2',
  #       'password': 'pass'
  #     }
  #   ],
  #   'name': 'rails2',
  #   'user': 'username',
  #   'folders': [],
  #   'rbenv': {
  #     'version': '2.0.0-p353',
  #     'gems': [
  #       'bundler'
  #     ]
  #   }
  # }
}
default['rails']['sites'] = {
  # 'mrcr': {
  #   'enabled': true,
  #   'delete': false,
  #   'name': 'mrcr2',
  #   'user': 'username',
  #   'php': {
  #     'modules': [
  #       'php-mysql',
  #       'php-postgresql',
  #       'php-memcached'
  #     ],
  #     'pool': {
  #       'allowed_clients': '127.0.0.1',
  #       'process_manager': 'dynamic',
  #       'max_children': 4,
  #       'start_servers': 2,
  #       'min_spare_servers': 1,
  #       'max_spare_servers': 3,
  #       'max_requests': 200,
  #       'catch_workers_output': 'yes',
  #       'request_slowlog_timeout': '5s',
  #       'backlog': '-1',
  #       'rlimit_files': '131072',
  #       'rlimit_core': 'unlimited',
  #       'production': true
  #     }
  #   },
  #   'smtp': {
  #     'host': 'smtp.gmail.com',
  #     'port': '587',
  #     'domain': 'mrcr.ru',
  #     'username': "noreply@mrcr.ru",
  #     'from': "noreply@mrcr.ru",
  #     'password': 'pass'
  #   },
  #   'nginx': {
  #     'vagrant_server': 'somedomain',
  #     'access_log': false,
  #     'error_log': true,
  #     'default': true,
  #     'deferred': true,
  #     'disable_www': true,
  #     'admin': true,
  #     'server_name': [
  #       'mrcr.ru'
  #     ],
  #     'min': false,
  #     'error_pages': [
  #       {
  #         'code': '404',
  #         'location': '/404.html'
  #       }
  #     ],
  #     'php_rewrites': [
  #       {
  #         'ext': 'html'
  #       }
  #     ],
  #     'rewrites': [
  #       {
  #         'query': "^(/update.*|/KnMp8rPwy9t33a2Fversion1104.*|/image.*)$",
  #         'uri': '/index.php',
  #         'options': 'permanent'
  #       },
  #     ],
  #     'file_rewrites': [
  #       {
  #         'query': "^(/update.*|/KnMp8rPwy9t33a2Fversion1104.*|/image.*)$",
  #         'uri': '/index.php',
  #         'options': 'permanent'
  #       },
  #     ],
  #   },
  #   'db': [
  #     {
  #       'type': 'mysql',
  #       'name': 'mrcr2_production',
  #       'user': 'mrcr2',
  #       'password': 'pass'
  #     }
  #   ]
  # }
}
default['rails']['user']['deploy']      = 'deploy'
default['vagrant']['fqdn'] = 'merq.dev'
default['rails']['databases'] = []
