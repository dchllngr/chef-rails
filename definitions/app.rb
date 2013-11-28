#
# Cookbook Name:: rails
# Definition:: app
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
define :app, application: false, type: "apps" do
  if params[:application]
    a = params[:application]
    type = params[:type]

    if a[:delete]
      if type.include? "sites" and a.include? "nginx"
        rails_nginx_vhost a["name"] do
          action :delete
        end
      end

      directory "#{node['rails']["#{type}_base_path"]}/#{a["name"]}" do
        action :delete
      end

      next
    end

    if type.include? "sites" and a.include? "nginx"
      unless a[:enable]      
        rails_nginx_vhost a["name"] do
          action :disable
        end        
        next
      end      
    end 

    directory "#{node['rails']["#{type}_base_path"]}/#{a["name"]}" do
      owner a["user"]
      group a["user"]
      mode "0750"
      recursive true
    end

    group a["user"] do
      append true
      members [node['nginx']['user']]
    end 

    if a.include? "smtp"      
      node.default['msmtp']['accounts'][a['user']][a["name"]]= a[:smtp]
      node.default['msmtp']['accounts'][a['user']][a["name"]][:syslog] = "on"
    end 

    if node.role? "base_ruby"
      if a.include? "rbenv"
        #set ruby
        unless a["rbenv"]["version"].include? node['rails']['rbenv']['version']
          rbenv_ruby "#{a["rbenv"]["version"]}" do
            ruby_version "#{a["rbenv"]["version"]}"
          end      
        end

        #add gems
        a["rbenv"]["gems"].each do |g|
          rbenv_gem "#{g}" do
            ruby_version "#{a["rbenv"]["version"]}"
          end
        end
      end
    end

    if a.include? "db"
      default_secret = Chef::EncryptedDataBagItem.load_secret("#{node['rails']['secrets']['default']}")
      a["db"].each do |d|
        node.default["rails"]["databases"][d["type"]][d["name"]] = {
          name: d["name"],
          user: d["user"],
          password: d["password"],
          app_type: type,
          app_name: a["name"],
          app_user: a["user"]                      
        }          
      end
    end

    if a.include? "php"
      if !File.exist?("/usr/bin/php")
        include_recipe "php"          
        package "php-gd"
        package "php-pecl-memcached"
        package "php-pecl-apcu"
        package "php-mbstring" do
          action :install
          notifies :reload, 'service[php-fpm]', :delayed
        end
      end

      include_recipe "composer"

      directory "/var/lib/php/session/#{a["name"]}" do
        owner a["user"]
        group a["user"]
        mode "0700"
        action :create
        recursive true
      end
      
      template "/etc/php.d/php_fix.ini" do
        owner "root"
        group "root"
        mode '755'
        source 'php_fix.erb'
        notifies :reload, 'service[php-fpm]', :delayed
      end
      node.default['php-fpm']['pools'].push(a["name"])
      node.default['php-fpm']['pool'][a["name"]] = node['php-fpm']['default']['pool']

      node.default['php-fpm']['pool'][a["name"]]['listen'] = "/var/run/php-fpm-#{a["name"]}.sock"
      node.default['php-fpm']['pool'][a["name"]]['user'] = a["user"]
      node.default['php-fpm']['pool'][a["name"]]['group'] = a["user"]     
      node.default['php-fpm']['pool'][a["name"]]['session_save_path'] = "/var/lib/php/session/#{a["name"]}"      
      node.default['php-fpm']['pool'][a["name"]]['slowlog'] = "#{node['rails']["#{type}_base_path"]}/#{a["name"]}/log/php-fpm-slowlog.log"
      node.default['php-fpm']['pool'][a["name"]]['error_log'] = "#{node['rails']["#{type}_base_path"]}/#{a["name"]}/log/php-fpm-error_log.log"
      
      if a[:php][:pool]
        a[:php][:pool].each do |key, value|
          node.default['php-fpm']['pool'][a["name"]][:"#{key}"] = value
        end
      end
    
    end
    
    if type.include? "sites" and a.include? "nginx"
      directory "#{node['rails']["#{type}_base_path"]}/#{a["name"]}/docs" do
        mode      '0755'
        owner     a['user']
        group     a['user']
        action    :create
        recursive true
      end
      directory "#{node['rails']["#{type}_base_path"]}/#{a["name"]}/log" do
        mode      '0755'
        owner     a['user']
        group     a['user']
        action    :create
        recursive true
      end
      if a.include? "smtp"
        node.default['msmtp']['accounts'][a['user']][a["name"]][:syslog] = "off"
        node.default['msmtp']['accounts'][a['user']][a["name"]][:log] = "#{node['rails']["#{type}_base_path"]}/#{a["name"]}/log/msmtp.log"        
        if a.include? "php"
          node.default['php-fpm']['pool'][a["name"]]['sendmail_path'] = "/usr/bin/msmtp -a #{a['name']} -t"
        end
      end
      server_name = a["nginx"]["server_name"].dup
      if node.role? "vagrant"
        server_name.push "#{a["nginx"]["vagrant_server_name"]}.#{node["vagrant"]["fqdn"]}" if a["nginx"]["vagrant_server_name"]
      end
      rails_nginx_vhost a["name"] do
        access_log a["nginx"]["access_log"]
        error_log a["nginx"]["error_log"]
        default a["nginx"]["default"] unless node.role? "vagrant"
        deferred a["nginx"]["deferred"] unless node.role? "vagrant"
        hidden a["nginx"]["hidden"]
        disable_www a["nginx"]["disable_www"]
        php a.include? "php"
        block a["nginx"]["block"]
        listen a["nginx"]["listen"]
        admin a["nginx"]["admin"]
        server_name server_name
        path "#{node['rails']["#{type}_base_path"]}/#{a["name"]}"
        rewrites a["nginx"]["rewrites"]
        file_rewrites a["nginx"]["file_rewrites"]
        action :create
      end
    end
  end
end