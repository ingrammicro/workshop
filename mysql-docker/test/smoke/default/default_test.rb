require 'json'

#Import node attributes that were previously exported in the "export-node" recipe
node = json("/tmp/kitchen/chef_node.json").params
node.default_proc = lambda{|h, k| h[k] = {}}

describe docker_container("#{node['default']['mysql']['hostname']}") do
  it { should exist }
  it { should be_running }
  its('image') { should eq "mysql:#{node['default']['mysql']['version']}" }
  its('ports') { should include "#{node['default']['mysql']['publishport']}" }
end
