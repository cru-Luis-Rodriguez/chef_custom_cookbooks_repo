author = search(:node, "role:author").first
Chef::Log.info("author private IP is '#{author[:private_ip]}'")
Chef::Log.info("author hostname is '#{author[:hostname]}'")
instance = "#{node[:hostname]}"
ipaddress = "#{node[:ipaddress]}"
port = "#{node['aem']['publish']['port']}"
user = "#{node['aem']['publish']['admin_user']}"
password = "#{node['aem']['publish']['admin_password']}"
name = "#{node[:fqdn]}"
type = "agent"
local_user = "#{node['aem']['author']['admin_user']}"
local_password = "#{node['aem']['author']['admin_password']}"


execute 'add_publish_agent' do
  command 'curl -u <%=local_user%>:<%=local_password%> -X POST http://<%=author%>:<%=local_port%>/etc/replication/agents.author/publish-<%=instance%>/_jcr_content -d jcr:title="<%=type%> Agent <%=instance%>" -d transportUri=http://<%=ipaddress%>:<%=port%>/bin/receive?sling:authRequestLogin=1 -d enabled=true -d transportUser=<%=user%> -d transportPassword=<%=password%> -d cq:template="/libs/cq/replication/templates/agent" -d retryDelay=60000 -d logLevel=info -d serializationType=durbo -d jcr:description="<%=type%> Agent <%=instance%>" -d sling:resourceType="cq/replication/components/agent"'
  action :run
end
