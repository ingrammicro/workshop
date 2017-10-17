name 'acronis-gateway'
maintainer 'Pablo Baños López'
maintainer_email 'pablob@softcom.com'
license 'All Rights Reserved'
description 'Installs/Configures Acronis Storage Gateway'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'docker', '~> 2.0'

supports 'ubuntu', '>= 14.04'

recipe 'acronis-gateway', 'Installs/Configures Acronis Storage Gateway'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/acronis-gateway/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/acronis-gateway'

attribute 'acronis-gateway/image',
    display_name: 'Acronis Gateway Docker image',
    description: 'Docker image with Acronis Gateway software to use',
    type: 'string',
    required: 'optional',
    default: 'ingrammicro/acronis-gateway:latest'

attribute 'acronis-gateway/image_tag',
    display_name: 'Acronis Gateway Docker image tag',
    description: 'Specific tag for Docker image with Acronis Gateway software to use',
    type: 'string',
    required: 'optional',
    default: 'latest'

attribute 'acronis-gateway/port',
    display_name: 'Port',
    description: 'Port on which Acronis Storage Gateway will be listening',
    type: 'string',
    required: 'required',
    default: '44445'

attribute 'acronis-gateway/backend',
    display_name: 'Storage Backend',
    description: 'Storage Backend where Acronis Storage Gateway will store your backup: a `local` directory in the machine or an `azure`, `s3` or (OpenStack) `swift` account',
    choice: %w(local azure s3 swift),
    type: 'string',
    required: 'optional',
    default: 'local'

attribute 'acronis-gateway/home_path',
    display_name: 'Home Path',
    description: 'Path at the storage backend on which Acronis Storage Gateway will store your files',
    type: 'string',
    required: 'optional',
    default: '/var/lib/Acronis/storage'

attribute 'acronis-gateway/chunk_storage_path',
    display_name: 'Chunk Storage Path',
    description: 'Path at the storage backend on which Acronis Storage Gateway will store chunks',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/login',
    display_name: 'Acronis login',
    description: 'The login for your administrator account in Acronis Backup Cloud',
    type: 'string',
    required: 'required'

attribute 'acronis-gateway/password',
    display_name: 'Acronis password',
    description: 'The password for your administrator account in Acronis Backup Cloud',
    type: 'string',
    required: 'required'

attribute 'acronis-gateway/mgmt_console_host',
    display_name: 'Acronis MGMT console host',
    description: 'The web address of the Acronis Backup Cloud management console',
    type: 'string',
    required: 'optional',
    default: 'cloud.acronis.com'

attribute 'acronis-gateway/gateway_fqdn',
    display_name: 'Acronis Gateway FQDN',
    description: 'The public DNS name or public IP of the gateway',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/storage_id',
    display_name: 'Storage ID',
    description: 'A unique name for the storage that will be displayed on the Storage tab of the Acronis Backup Cloud management console',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/s3_access_key_id',
    display_name: 'S3 Access Key ID',
    description: 'The Access Key ID for the S3 account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/s3_region',
    display_name: 'S3 Region',
    description: 'The S3 region for the S3 account to use as backend',
    type: 'string',
    required: 'optional',
    default: 'us-east-1'

attribute 'acronis-gateway/s3_secret_access_key',
    display_name: 'S3 Secret Access Key',
    description: 'The Secret Access Key for the S3 account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/azure_account',
    display_name: 'Microsoft Azure account name',
    description: 'The name of the Microsoft Azure account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/azure_access_key',
    display_name: 'Microsoft Azure secondary access key',
    description: 'The secondary access key for the Microsoft Azure account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/swift_api_version',
    display_name: 'OpenStack Swift API version',
    description: 'The API version used by the Keystone identity service providing access to the OpenStack Swift account to use as backend',
    choice: %w(v1 v2 v3),
    type: 'string',
    required: 'optional',
    default: 'v3'

attribute 'acronis-gateway/swift_keystone_service_url',
    display_name: 'OpenStack Swift Keystone URL',
    description: 'The URL for the Keystone identity service providing access to the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/swift_user_domain_id',
    display_name: 'OpenStack Swift user domain ID',
    description: 'The domain ID for the user of the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional',
    default: 'default'

attribute 'acronis-gateway/swift_user_name',
    display_name: 'OpenStack Swift user name',
    description: 'The name for the user of the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/swift_password',
    display_name: 'OpenStack Swift password',
    description: 'The password for the user of the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional'

attribute 'acronis-gateway/swift_project_domain_id',
    display_name: 'OpenStack Swift project domain ID',
    description: 'The domain ID for the project of the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional',
    default: 'default'

attribute 'acronis-gateway/swift_project_name',
    display_name: 'OpenStack Swift project domain ID',
    description: 'The domain ID for the project of the OpenStack Swift account to use as backend',
    type: 'string',
    required: 'optional'
