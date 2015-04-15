#
# Cookbook Name:: s3bucket_ops
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe 'aws'

aws_s3_file "/tmp/license.properties" do
  bucket "cru-aem6"
  remote_path "/installation_files/license.properties"
  aws_access_key_id node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
end

aws_s3_file "/tmp/cq60-author-p4502.jar" do
  bucket "cru-aem6"
  remote_path "/installation_files/cq60-author-p4502.jar"
  aws_access_key_id node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
end