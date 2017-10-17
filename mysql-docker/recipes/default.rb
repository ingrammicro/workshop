#
# Cookbook:: mysql-docker
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

docker_service('default')

#directory (node[:mysql][:dir]).to_s do
#  owner 'root'
#  group 'docker'
#  mode '0755'
#  recursive true
#  action :create
#end

docker_image 'mysql' do
  tag "#{node[:mysql][:version]}"
  action :pull_if_missing
end

docker_container "#{node[:mysql][:hostname]}" do
  repo 'mysql'
  tag "#{node[:mysql][:version]}"
  host_name "#{node[:mysql][:hostname]}"
  command "mysqld --character-set-server=utf8 --collation-server=utf8_bin"
  env [
    "MYSQL_ROOT_PASSWORD=#{node[:mysql][:root_password]}",
    "MYSQL_DATABASE=#{node[:mysql][:app][:database]}",
    "MYSQL_USER=#{node[:mysql][:app][:username]}",
    "MYSQL_PASSWORD=#{node[:mysql][:app][:password]}"
  ]
  port "#{node[:mysql][:publishport]}:#{node[:mysql][:port]}"
  volumes ["mysql_data:/var/lib/mysql"]
end

ruby_block "Save node attributes" do
  block do
    if Dir::exist?('/tmp/kitchen')
      IO.write("/tmp/kitchen/chef_node.json", node.to_json)
    end
  end
end
