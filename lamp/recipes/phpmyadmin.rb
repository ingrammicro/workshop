docker_image 'phpmyadmin/phpmyadmin' do
  action :pull_if_missing
end

docker_container 'phpmyadmin' do
  repo 'phpmyadmin/phpmyadmin'
  port '81:80'
  env ["PMA_HOST=#{node[:mysql][:hostname]}","PMA_PORT=#{node[:mysql][:port]}"]
  links ["#{node[:mysql][:hostname]}:mysql"]
end
