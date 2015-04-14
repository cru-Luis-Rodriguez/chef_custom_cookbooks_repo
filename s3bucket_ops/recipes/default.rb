#
# Cookbook Name:: s3bucket_ops
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe 'aws'

aws_s3_file "#{Chef::Config[:file_cache_path]}/install/aem/license.properties" do
  bucket "cru-aem6"
  remote_path "/installation_files/license.properties"
  aws_access_key_id node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
end#
