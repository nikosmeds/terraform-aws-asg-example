# Apache Server

Use an EC2 auto scaling group to deploy an apache web server.

## Terraform

| Status | State
| --- | ---
| 60% complete | Draft

[x] Create a VPC.
[] Create an EC2 ASG to be configured as a web server.
[] Create auto scaling rules that trigger at 40% CPU.

## Chef

| Status | State
| --- | ---
| 20% complete | Research and planning

Status: 20% complete.
In progress: Creating chef directory for chef-solo use.

[] Install chefdk on server.
[] Generate and configure server setup and apache cookbooks.
[] Genarate runlist.
[] Install and enable git, ntpd.
[] Create index.html.erb which dynamically gets IP address and hostname from Ohai.
[] Sending and receiving notificaitons (subscribe, etc).
[] Create simple unit test using chefspec and/or use of Chef Kitchen.

# Notes

## Configuration plan

* Manually generate the chef-solo directories and configuration on test intance.
* Confirm `chef-solo` successfully self-applies.
* Copy/pasta the directory structure to workstation, add to `playground` repository.

## Provisoning plan

* Terraform provisions infrastructure.
* Terraform loads user-data to install git, chefdk, and other requirements, clone `playground` repository, and use `chef-solo` to self-apply cookbook.
