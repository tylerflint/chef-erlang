#
# Cookbook Name:: erlang
# Recipe:: default
#
# Copyright (C) 2013 Tyler Flint
# 
# All rights reserved - Do Not Redistribute
#

# 0- Validate
supported_platforms = ['ubuntu']
if not supported_platforms.include? node[:platform]
  Chef::Log.info("#{node[:platform]} is not yet supported :(")
  exit(1)
end

# 1- Install
include_recipe "erlang::#{node[:platform]}"

