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
end

