package 'apache2' do
  version '2.4.18-2ubuntu3.5'
  action :install
end

%w{curl ntp tree vim}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

service 'apache2' do
  subscribes :reload, 'file[var/www/html/index.html]', :immediately
end

template '/var/www/html/index.html' do
  source "index.html.erb"
  mode   '0644'
  owner  'root'
  group  'root'
end
