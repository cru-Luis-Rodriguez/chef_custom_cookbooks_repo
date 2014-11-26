#
# Cookbook Name:: yum update
# Recipe:: default
#
# Copyright 2013, Luis Rodriguez
#


  # run yum update silent
  execute "yum-update" do
    command "yum -y update"
    action :run
  end

