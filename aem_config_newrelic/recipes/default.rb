#
# Cookbook Name:: aem_config_newrelic
# Recipe:: default
#
# Copyright 2014, cru
#
# All rights reserved - Do Not Redistribute
#

cq_dir = node['cq']['install_path']

directory "#{cq_dir}/temp" do
    owner "cq"
    group "cq"
    mode "0755"
    action :create
end

service 'cqauthor' do
    supports :status => true, :restart => true
    provider Chef::Provider::Service::Init
end

service 'cqpublish' do
    supports :status => true, :restart => true
    provider Chef::Provider::Service::Init
end

#if ["prod.publish1"].include?(Chef::Config[:node_name])
	template "#{cq_dir}/publish/crx-quickstart/bin/start" do
    	source 'start_pub.erb'
        owner "cq"
        group "cq"
    	mode 0755 
    	variables(
              	:default_env => node['newrelic']['java_agent']['environment']
              	)
              	notifies :restart, "service[cqpublish]", :immediately
only_if {["prod.publish1"].include?(Chef::Config[:node_name])}
	end
#end

#if ["prod.publish2"].include?(Chef::Config[:node_name])
        template "#{cq_dir}/publish/crx-quickstart/bin/start" do
        source 'start_pub.erb'
        owner "cq"
        group "cq"
        mode 0755
        variables(
                :default_env => node['newrelic']['java_agent']['environment']
                )
                notifies :restart, "service[cqpublish]", :immediately
only_if {["prod.publish2"].include?(Chef::Config[:node_name])}
        end
#end

#if ["prod.author"].include?(Chef::Config[:node_name])
	template "#{cq_dir}/author/crx-quickstart/bin/start" do
    	source 'start_auth.erb'
        owner "cq"
	group "cq"
    	mode 0755 
    	variables(
              	:default_env => node['newrelic']['java_agent']['environment']
              	)
              	notifies :restart, "service[cqauthor]", :immediately
only_if {["prod.author"].include?(Chef::Config[:node_name])}
	end
#end
