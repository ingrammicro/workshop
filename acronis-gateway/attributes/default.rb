
default['acronis-gateway'][:image] = 'pbanos/acronis-gateway'
default['acronis-gateway'][:image_tag] = 'latest'
default['acronis-gateway'][:port] = 44445
default['acronis-gateway'][:backend] = 'local'
default['acronis-gateway'][:home_path] = '/var/lib/Acronis/storage'
default['acronis-gateway'][:mgmt_console_host] = 'cloud.acronis.com'
default['acronis-gateway'][:gateway_fqdn] = node['fqdn']
default['acronis-gateway'][:storage_id] = begin
    File.read('/etc/Acronis/storage_id')
rescue
    rand(32**16).to_s(32)
end
default['acronis-gateway'][:s3_region] = 'us-east-1'
default['acronis-gateway'][:swift_api_version] = 'v3'
default['acronis-gateway'][:swift_user_domain_id] = 'default'
default['acronis-gateway'][:swift_project_domain_id] = 'default'
