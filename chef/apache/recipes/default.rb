node.default['apache']['dir']     = "/var/www/html"
node.default['apache']['version'] = "2.4.18-2ubuntu3.7"

apt_update 'update' do
  action :update
end

package 'apache2' do
  version "#{node['apache']['version']}"
  action :install
end

service 'apache2' do
  action [:enable, :start]
end

%w{curl ntp tree vim}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

template "#{node['apache']['dir']}/index.html" do
  source   'index.html.erb'
  mode     '0644'
  owner    'root'
  group    'root'
  notifies :reload, 'service[apache2]', :immediately
end
