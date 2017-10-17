# # encoding: utf-8

# Inspec test for recipe acronis-gateway::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
require 'json'

#Import node attributes that were previously exported in the "export-node" recipe
node = json("/tmp/inspec/chef_node.json").params
node.default_proc = lambda{|h, k| h[k] = {}}

# This is an example test, replace it with your own test.
describe port(44445) do
  it { should be_listening }
end

describe docker_image('pbanos/acronis-gateway:latest') do
  it { should exist }
end

describe docker_container('acronis-gateway') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'pbanos/acronis-gateway'}
  its('tag') { should eq 'latest' }
  its('ports') { should eq '0.0.0.0:44445->44445/tcp' }
  its('command') { should eq '/entrypoint.sh' }
end

describe docker.containers.where{ names == 'acronis-gateway' } do
  %w(/var/lib/Acronis/storage /var/lib/Acronis/acronis-storage-mds /etc/pki/tls/certs/Acronis/storage /var/log/Acronis
  /etc/Acronis/acronis-storage-gateway.xml /etc/Acronis/acronis-storage-mds.xml).each do |mount|
    its('mounts') { should include /(\A|,)#{Regexp.escape(mount)}(,|\Z)/ }
  end
end

%w(crl_url_reg dc.crl dc.crt fes.pem reg.crl reg.crt root.crl root.crt).each do |crt_file|
  describe file("/etc/pki/tls/certs/Acronis/storage/#{crt_file}") do
    it { should exist }
    its('content'){ should_not be_empty }
  end
end

describe file("/var/lib/Acronis/acronis-storage-mds/journal") do
  it { should exist }
end

describe file("/etc/Acronis/storage_id") do
  it { should exist }
  its('content'){ should eq node['acronis-gateway']['storage_id']}
end

{
  ACRONIS_USERNAME: node['acronis-gateway']['login'],
  ACRONIS_PASSWORD: node['acronis-gateway']['password'],
  ACRONIS_HOST: node['acronis-gateway']['mgmt_console_host'],
  ACRONIS_GATEWAYADDRESS: "#{node['acronis-gateway']['gateway_fqdn']}:#{node['acronis-gateway']['port']}",
  ACRONIS_STORAGE_UID: node['acronis-gateway']['storage_id']
}.each do |env_var, value|
  describe command("sudo docker exec -t acronis-gateway bash -c 'echo $#{env_var}'") do
    its('stdout') { should match /\A#{Regexp.escape(value)}\r?\n\Z/ }
  end
end