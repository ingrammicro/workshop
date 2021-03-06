name 'lamp'
maintainer 'Ingram'
maintainer_email 'imco@ingrammicro.com'
license 'All Rights Reserved'
description 'Installs/Configures lamp'
long_description 'Installs/Configures lamp'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w(mysql-docker docker).each do |cookbook|
	depends cookbook
end

supports 'ubuntu'

recipe 'lamp', 'Installs and configures LAMP'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/lamp/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/lamp'

attribute 'lamp/apache/document_root',
  display_name: 'Apache document root',
  description: 'Desired Apache document root path',
  type: 'string',
  required: 'optional',
  default: '/var/www/html'

attribute 'lamp/apache/port',
	display_name: 'Apache port',
	description: 'Port on which Apache should listen',
	type: 'string',
	required: 'optional',
	default: '80'

attribute 'lamp/php/directive/memory_limit',
	display_name: 'php dir. memory_limit',
	description: 'PHP memory limit',
	type: 'string',
	required: 'optional',
	default: '32M'

attribute 'lamp/php/directive/max_execution_time',
	display_name: 'php dir. max_execution_time',
	description: 'PHP max script execution time in seconds',
	type: 'string',
	required: 'optional',
	default: '20'

attribute 'lamp/php/directive/display_errors',
	display_name: 'php dir. display_errors',
	description: 'Display PHP errors',
	type: 'string',
	required: 'optional',
	default: 'on'

attribute 'lamp/php/directive/expose_php',
	display_name: 'php dir. expose_php',
	description: 'Expose PHP version',
	type: 'string',
	required: 'optional',
	default: 'on'

attribute 'lamp/php/directive/allow_url_fopen',
  display_name: 'php dir. allow_url_fopen',
  description: 'Enables/disables the URL-aware fopen wrappers that enable accessing URL object like files',
  type: 'string',
  required: 'optional',
  default: 'on'

attribute 'lamp/php/directive/allow_url_include',
  display_name: 'php dir. allow_url_include',
  description: 'This option allows the use of URL-aware fopen wrappers with the following functions: include, include_once, require, require_once. Requires allow_url_fopen',
  type: 'string',
  required: 'optional',
  default: 'on'

attribute 'lamp/php/directive/short_open_tag',
  display_name: 'php dir. short_open_tag',
  description: 'Allow PHP short tags',
  type: 'string',
  required: 'optional',
  default: 'on'

attribute 'lamp/ftp/user',
	display_name: 'FTP username',
	description: 'Username to be created for FTP login',
	type: 'string',
	required: 'required'

attribute 'lamp/ftp/password',
	display_name: 'FTP password',
	description: 'Password for the FTP user',
	type: 'string',
	required: 'required'

attribute 'lamp/phpmyadmin/install',
	display_name: 'Install phpmyadmin?',
	description: 'Whether to install PhpMyAdmin',
	type: 'string',
	required: 'optional',
	default: 'true'
