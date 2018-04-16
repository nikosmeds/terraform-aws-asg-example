# Project Summary

## Terraform

Status: 60% complete.
In progress: Move EC2 instance to ASG.

1. Create a VPC.
2. Create an EC2 ASG to be configured as a web server.
3. Create auto scaling rules that trigger at 40% CPU.

## Chef

Status: 0% complete.
In progress: Research and planning.

1. Install chefdk on server.
2. Generate and configure server setup and apache cookbooks.
3. Genarate runlist.
4. Install and enable git, ntpd.
5. Create index.html.erb which dynamically gets IP address and hostname from Ohai.
6. Sending and receiving notificaitons (subscribe, etc).
7. Create simple unit test using chefspec and/or use of Chef Kitchen.

---

# Planning

## Provisoning plan

1. Terraform: provision infrastructure.
2. Terraform user-data:
- install git, chefdk, and other requirements.
- clone `playground` repository to instance.
- use `chef-solo` to self-apply cookbook.

## Configuration plan

- manually make the chef-solo directories/structure on a test intance.
- confirm `chef-solo` can properly self-apply.
- copy/pasta the directory structure to workstation, add to `playground` repository.

---

# Niko's notes

## Server setup

$ sudo apt update
$ sudo apt upgrade
$ sudo apt install tree

$ wget -P /var/cache/apt/archives/ https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
$ dpkg -i /var/cache/apt/archives/chefdk_2.5.3-1_amd64.deb
$ sudo git clone https://github.com/thesmeds/playground.git /srv/playground/
$ sudo chef-solo -c /srv/playground/chef/solo.rb -j /srv/playground/chef/web.json

# Generate the repository structure
chef generate repo <repo_name>
chef generate app <app_name>
chef generate cookbook <cookbook_name>

### /home/ubuntu/chef/solo.rb
file_cache_path "/home/ubuntu/cache"
cookbook_path "/home/ubuntu/chef"

### /home/ubuntu/chef/web.json
{
 "run_list": [ "recipe[first_cookbook]" ]
}

### /home/ubuntu/chef/first_cookbook/recipes/default.rb 
package 'ntp'
package 'apache2'

hostname = 'replace_with_ohai_lookup'

file '/var/www/html/index.html' do
  content "#{hostname}\n"
end


$ sudo chef-solo -c /srv/playground/chef/solo.rb -j /srv/playground/chef/web.json
