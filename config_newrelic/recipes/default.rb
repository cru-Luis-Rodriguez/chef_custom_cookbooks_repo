#
# Cookbook Name:: config_newrelic
# Recipe:: default
#
# Copyright 2014, cru
#
# All rights reserved - Do Not Redistribute
#

CAS_dir = node['tomcat-cas']['install_path']

directory "#{CAS_dir}/temp" do
    owner "node['newrelic']['java_agent']['app_user']"
    group "node['newrelic']['java_agent']['app_user']"
    mode "0755"
    action :create
only_if { File.exist?("#{CAS_dir}") }
end

service 'tomcat-cas' do
    supports :status => true, :restart => true
    provider Chef::Provider::Service::Init
end

template "#{CAS_dir}/bin/catalina.sh" do
    source 'catalina.erb'
    mode 0755
    variables(
              :default_env => node['newrelic']['java_agent']['environment']
              )
              notifies :restart, "service[tomcat-cas]", :immediately
only_if { File.exist?("#{CAS_dir}/tomcat-cas/bin") }
end



