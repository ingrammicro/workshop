docker_image 'php' do
  tag '7-apache'
  action :pull_if_missing
end

%w(docroot conf).each do |vol_name|
  docker_volume vol_name do
    action :create
  end
end

docker_container 'apache-php' do
  repo 'php'
  tag '7-apache'
  port ["#{node['lamp']['apache']['port']}:80"]
  volumes ["apache_document_root:#{node['lamp']['apache']['document_root']}",'etc_apache2:/etc/apache2', "php_conf:#{node['lamp']['php']['conf_dir']}"]
  links ["#{node[:mysql][:hostname]}:mysql"]
end

docker_exec 'Modify document_root owner to www-data' do
  container 'apache-php'
  command ['chown', '-R', 'www-data:', "#{node['lamp']['apache']['document_root']}"]
end

template "/var/lib/docker/volumes/php_conf/_data/php-directives.ini" do
    source 'php-directives.ini.erb'
    unless platform?('windows')
        owner 'root'
        group 'root'
        mode '0644'
    end
    variables(:directives => node['lamp']['php']['directive'])
    notifies :restart,'docker_container[apache-php]', :delayed
end

execute "install php module #{node['lamp']['php']['modules']}" do
  command "docker exec apache-php docker-php-ext-install #{node['lamp']['php']['modules']}"
  notifies :restart,'docker_container[apache-php]', :delayed
end
