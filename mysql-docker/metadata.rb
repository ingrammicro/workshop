name 'mysql-docker'
maintainer 'Ingram Micro'
maintainer_email 'imco@ingrammicro.com'
license 'All Rights Reserved'
description 'Installs/Configures mysql-docker'
long_description 'Installs/Configures mysql-docker'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'docker'


attribute 'mysql/version',
    display_name: 'MySQL version',
    description: 'MySQL version to install',
    type: 'string',
    required: 'optional',
    default: '5.6.23'

attribute 'mysql/root_password',
    display_name: 'MySQL root password',
    description: 'MySQL root password',
    type: 'string',
    required: 'optional',
    default: ''

attribute 'mysql/hostname',
    display_name: 'MySQL server hostname',
    description: 'MySQL server hostname',
    type: 'string',
    required: 'optional',
    default: 'mysql'

attribute 'mysql/publishport',
    display_name: 'MySQL server port',
    description: 'MySQL server port',
    type: 'string',
    required: 'optional',
    default: '3306'

attribute 'mysql/app/database',
    display_name: 'Database name',
    description: 'If specified, a new database will be created with that name',
    type: 'string',
    required: 'optional',
    default: ''

attribute 'mysql/app/username',
    display_name: 'Database user',
    description: 'If specified, a new user will be created with the specified name and GRANT ALL on the database name',
    type: 'string',
    required: 'optional',
    default: ''

attribute 'mysql/app/password',
    display_name: 'Database user password',
    description: 'Desired password for the database user',
    type: 'string',
    required: 'optional',
    default: ''
