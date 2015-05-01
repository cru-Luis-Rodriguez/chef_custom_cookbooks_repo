require "erb"

author = search(:node, "role:author").first
  Chef::Log.info("author private IP is '#{author[:private_ip]}'")
  Chef::Log.info("author hostname is '#{author[:hostname]}'")
  log ("Found author host: '#{author['private_dns_name']}'")

author_host = "#{author[:private_ip]}"
author_port = node['aem']['author']['port']
instance = node['hostname']
ipaddress = node['ipaddress']
port = node['aem']['publish']['port']
user = node['aem']['publish']['admin_user']
password = node['aem']['publish']['admin_password']
name = node[:fqdn]
type = "agent"
local_user = node['aem']['author']['admin_user']
local_password = node['aem']['author']['admin_password']

host = []

host << {
    :author_host => author['private_ip'],
    :instance => node['hostname'],
    :ipaddress => node['ipaddress'],
    :port => node['aem']['publish']['port'],
    :user => node['aem']['publish']['admin_user'],
    :password => node['aem']['publish']['admin_password'],
    :local_user => node['aem']['author']['admin_user'],
    :local_password => node['aem']['author']['admin_password']
  }

host.each do |h|
  cmd = ERB.new(node[:aem][:aws_command][:replicator][:dispatcher][:create]).result(binding)
   log "creating flush agent with command: #{cmd}"
    runner = Mixlib::ShellOut.new(cmd)
    runner.run_command
    runner.error!
end

host do 
  cmd = ERB.new(node[:aem][:aws_command][:replicator][:dispatcher][:add]).result(binding)
   log "adding flush agent with command: #{cmd}"
    runner = Mixlib::ShellOut.new(cmd)
    runner.run_command
    runner.error!
end

  