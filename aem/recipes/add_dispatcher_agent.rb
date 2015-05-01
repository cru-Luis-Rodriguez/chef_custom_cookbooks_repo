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

default[:aem][:command] = {
:dispatcher => { :create => 'curl -F jcr:primaryType=cq:Page -F jcr:content= -u <%=local_user%>:<%=local_password%> http://<%=author_host%>:<%=author_port%>/etc/replication/agents.author/dispatcher<%=instance%>',
                 :add => 'curl -u <%=local_user%>:<%=local_password%> -X POST http://<%=author_host%>:<%=author_port%>/etc/replication/agents.author/flush<%=instance%>/_jcr_content  -d transportUri=http://<%=ipaddress%>/dispatcher/invalidate.cache -d enabled=true -d transportUser=<%=user%> -d transportPassword=<%=password]%> -d jcr:title=flush<%=instance%> -d jcr:description=flush<%=instance%> -d serializationType=flush -d cq:template=/libs/cq/replication/templates/agent -d sling:resourceType="cq/replication/components/agent" -d retryDelay=60000 -d logLevel=info -d triggerSpecific=true -d triggerReceive=true'}
}

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

host do 
  cmd = ERB.new(node[:aem][:command][:dispatcher][:create]).result(binding)
   log "creating flush agent with command: #{cmd}"
    runner = Mixlib::ShellOut.new(cmd)
    runner.run_command
    runner.error!
end

host do 
  cmd = ERB.new(node[:aem][:command][:dispatcher][:add]).result(binding)
   log "adding flush agent with command: #{cmd}"
    runner = Mixlib::ShellOut.new(cmd)
    runner.run_command
    runner.error!
end

  