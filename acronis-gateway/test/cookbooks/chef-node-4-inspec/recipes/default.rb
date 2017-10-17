directory File.dirname(node['chef-node-4-inspec']['file']) do
    owner 'root'
    group 'root'
    mode '0777'
    recursive true
    action :create
end

ruby_block "Save node attributes" do
    block do
        IO.write(node['chef-node-4-inspec']['file'], Hash[node.map do |k, v|
            [k, v]
        end].to_json)
    end
end