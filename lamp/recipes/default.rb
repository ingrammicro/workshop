#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2017, Ingram, All Rights Reserved.

#Install Docker
docker_service('default')

include_recipe 'lamp::mysql-server'
include_recipe 'lamp::apache-php'
include_recipe 'lamp::ftp-server'
unless #{node['lamp']['phpmyadmin']['install']} == 'false'
  include_recipe 'lamp::phpmyadmin'
end
