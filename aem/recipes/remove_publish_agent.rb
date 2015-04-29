author = search(:node, "role:author").first
Chef::Log.info("author private IP is '#{author[:private_ip]}'")
Chef::Log.info("author hostname is '#{author[:hostname]}'")
author_host ="#{author[:private_ip]}"
instance = "#{node[:hostname]}"
ipaddress = "#{node[:ipaddress]}"
port = "#{node['aem']['publish']['port']}"
user = "#{node['aem']['publish']['admin_user']}"
password = "#{node['aem']['publish']['admin_password']}"
name = "#{node[:fqdn]}"
type = "agent"
local_user = "#{node['aem']['author']['admin_user']}"
local_password = "#{node['aem']['author']['admin_password']}"


execute 'remove_publish_agent' do
  command 'curl -u <%=local_user%>:<%=local_password%> -X DELETE http://<%=author_host%>:<%=local_port%>/etc/replication/agents.author/publish-<%=instance%>'
  action :run
end


