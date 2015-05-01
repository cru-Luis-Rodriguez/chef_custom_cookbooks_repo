author = search(:node, "role:author").first
  Chef::Log.info("author private IP is '#{author['private_ip']}'")
  Chef::Log.info("author hostname is '#{author['hostname']}'")
  log ("Found author host: '#{author['private_dns_name']}'")

directory '/opt/scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/opt/scripts/add_publish.sh' do
  source 'add_publish.erb'
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

execute 'add_publish' do
  command '/opt/scripts/add_publish.sh'
  action :run
end

