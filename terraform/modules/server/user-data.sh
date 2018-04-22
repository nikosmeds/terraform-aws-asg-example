#!/bin/bash

echo 'Running bootstrap.sh' | logger -t user-data

echo 'Downloading ChefDK' | logger -t userdata
wget -P /var/cache/apt/archives/ https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb

echo 'Installing ChekDK' | logger -t user-data
dpkg -i /var/cache/apt/archives/chefdk_2.5.3-1_amd64.deb

echo 'Cloning `playground` repository' | logger -t user-data
git clone https://github.com/thesmeds/playground.git /srv/playground/

echo 'Running chef-solo' | logger -t user-data
chef-solo -c /srv/playground/chef/solo.rb -j /srv/playground/chef/web.json
