docker_image 'panubo/vsftpd' do
  action :pull_if_missing
end

docker_container 'vsftpd' do
  repo 'panubo/vsftpd'
  volume_from 'apache-php'
  #port ['20:20','21:21','4559-4564:4559-4564']
  env ["FTP_USER=#{node['lamp']['ftp']['user']}","FTP_PASSWORD=#{node['lamp']['ftp']['password']}"]
  network_mode 'host'
end

execute 'Set homedir FTP user to Apache document_root ' do
  command "docker exec vsftpd sed -i 's!local_root=/srv/!local_root=#{node['lamp']['apache']['document_root']}!' /etc/vsftpd.conf"
  not_if "docker exec vsftpd grep 'local_root=#{node['lamp']['apache']['document_root']}' /etc/vsftpd.conf"
  notifies :restart,'docker_container[vsftpd]', :immediately
end

execute 'Alow FTP user to write in Apache document_root' do
  command "docker exec vsftpd bash -c \'usermod -G www-data ftp && chmod g+w #{node['lamp']['apache']['document_root']}\'"
  action :run
end
