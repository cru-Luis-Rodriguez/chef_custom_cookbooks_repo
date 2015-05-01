author = search(:node, "role:author").first
  Chef::Log.info("author private IP is '#{author['private_ip']}'")
  Chef::Log.info("author hostname is '#{author['hostname']}'")
  log ("Found author host: '#{author['private_dns_name']}'")



template '/opt/scripts/remove_dispatcher.sh' do
  source 'remove_dispatcher.erb'
  owner "root"
  group "root"
  mode 0654
  variables(
    :author_host => author['private_ip'],
    :author_port => node['aem']['author']['port'],
    :instance => node['hostname'],
    :ipaddress => node['ipaddress'],
    :port => node['aem']['publish']['port'],
    :user => node['aem']['publish']['admin_user'],
    :password => node['aem']['publish']['admin_password'],
    :local_user => node['aem']['author']['admin_user'],
    :local_password => node['aem']['author']['admin_password']
  )
end

execute 'remove_dispatcher' do
  command '/opt/scripts/remove_dispatcher.sh'
  action :run
end


