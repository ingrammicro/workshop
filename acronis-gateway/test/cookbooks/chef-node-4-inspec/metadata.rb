name 'chef-node-4-inspec'
maintainer 'Pablo Baños López'
maintainer_email 'pablob@softcom.com'
license 'All Rights Reserved'
description 'Stores node in file for inspec to find'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

attribute 'chef-node-4-inspec/file',
    display_name: 'Filepath',
    description: 'Path to file where cookbook will store node',
    type: 'string',
    required: 'optional',
    default: '/tmp/inspec/chef_node.json'