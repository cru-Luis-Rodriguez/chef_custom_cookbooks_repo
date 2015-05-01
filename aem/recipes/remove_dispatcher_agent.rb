author = search(:node, "role:author").first
  Chef::Log.info("author private IP is '#{author[:private_ip]}'")
  Chef::Log.info("author hostname is '#{author[:hostname]}'")
  log ("Found author host: '#{author['private_dns_name']}'")

author_host = "#{author[:private_ip]}"
author_port = node['aem']['author']['port']
instance = node['hostname']
ipaddress = node['ipaddress']
port = node['aem']['dispatcher']['port']
user = node['aem']['dispatcher']['admin_user']
password = node['aem']['dispatcher']['admin_password']
name = node[:fqdn]
type = "agent"
local_user = node['aem']['author']['admin_user']
local_password = node['aem']['author']['admin_password']



execute 'remove_dispatcher_agent' do
  command 'curl -u <%=l@ocal_user%>:<%=@local_password%> -X DELETE http://<%=@author_host%>:<%=@author_port%>/etc/replication/agents.author/dispatcher<%=@instance%>'
  action :run
end


