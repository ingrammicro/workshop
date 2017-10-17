#
# Cookbook:: acronis-gateway
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


directory '/etc/Acronis' do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
end

config_files = [
    'gateway',
    'mds',
    if %w(azure s3 swift).include?(node['acronis-gateway'][:backend])
        "backend-#{node['acronis-gateway'][:backend]}"
    end
].compact.map do |config|
    "/etc/Acronis/acronis-storage-#{config}.xml"
end

config_files.map do |config_file|
    template config_file do
        source "#{config_file.split('/').last}.erb"
        owner 'root'
        group 'root'
        mode '0600'
        notifies :restart, 'docker_container[acronis-gateway]'
    end
end

directories = %w(/var/lib/Acronis/storage /var/lib/Acronis/acronis-storage-mds /etc/pki/tls/certs/Acronis/storage /var/log/Acronis)

directories.map do |dir|
    directory dir do
        owner 'root'
        group 'root'
        mode '0755'
        recursive true
        action :create
    end
end

file '/var/lib/Acronis/acronis-storage-mds/journal' do
    content ''
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
end

docker_service 'default' do
    action [:create, :start]
end

docker_image node['acronis-gateway'][:image] do
    tag node['acronis-gateway'][:image_tag]
    action :pull
    notifies :redeploy, 'docker_container[acronis-gateway]'
end

file '/etc/Acronis/storage_id' do
    content node['acronis-gateway'][:storage_id]
    mode '0644'
    owner 'root'
    group 'root'
end

docker_container 'acronis-gateway' do
    repo node['acronis-gateway'][:image]
    tag node['acronis-gateway'][:image_tag]
    port "#{node['acronis-gateway'][:port]}:#{node['acronis-gateway'][:port]}"
    env(
        {
            ACRONIS_USERNAME: node['acronis-gateway'][:login],
            ACRONIS_PASSWORD: node['acronis-gateway'][:password],
            ACRONIS_HOST: node['acronis-gateway'][:mgmt_console_host],
            ACRONIS_GATEWAYADDRESS: "#{node['acronis-gateway'][:gateway_fqdn]}:#{node['acronis-gateway'][:port]}",
            ACRONIS_STORAGE_UID: node['acronis-gateway'][:storage_id]
        }.map{|var, val| "#{var}=#{val}"})
    volumes [ 
        *(config_files.map do |config_file|
            "#{config_file}:#{config_file}:ro"
        end),
        *(directories.map do |dir|
            "#{dir}:#{dir}"
        end)
    ]
end