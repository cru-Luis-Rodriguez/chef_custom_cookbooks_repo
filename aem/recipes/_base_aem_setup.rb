#
# Cookbook Name:: aem
# Recipe:: _base_aem_setup
#
# Copyright 2012, Tacit Knowledge, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# We need these for the jcr_node provider
execute 'apt-get-update' do
  command 'apt-get update'
  ignore_failure true
  only_if { apt_installed? }
  not_if { ::File.exist?('/var/lib/apt/periodic/update-success-stamp') }
end

package "libcurl4-gnutls-dev" do
  action :upgrade
end
package "libcurl4-openssl-dev" do
  action :upgrade
end
package "maven" do
  action :upgrade
end
package "ruby" do
  action :upgrade
end
package "git" do
  action :upgrade
end
package "gcc" do
  action :upgrade
end

gem_package "bundler" do
  action :install
  ignore_failure true
end

execute 'install_curb' do
  command 'sudo gem install curb'
  ignore_failure true
  not_if ' /usr/bin/gem list -d curb | grep -q curb '
end  

require 'curb'

unless node['aem']['license_url']
  Chef::Application.fatal! 'aem.license_url attribute cannot be nil. Please populate that attribute.'
end

unless node['aem']['download_url']
  Chef::Application.fatal! 'aem.download attribute cannot be nil. Please populate that attribute.'
end

# See if we can get this value early enough from AEM itself so we don't have to ask for it.
unless node['aem']['version']
  Chef::Application.fatal! 'aem.version attribute cannot be nil. Please populate that attribute.'
end

include_recipe "java"
package "unzip"

if node[:aem][:use_yum] then
  package 'aem' do
    version node[:aem][:version]
    action :install
  end
else
  user "crx" do
    comment "crx/aem role user"
    system true
    shell "/bin/bash"
    home "/home/crx"
    supports :manage_home => true
    action :create
  end
end

directory "/home/crx/.ssh" do
  owner "crx"
  group "crx"
  mode 0700
end
