## Apache Server :: Chef

* Install chefdk on server.
* Generate and configure server setup and apache cookbooks.
* Genarate runlist.
* Install and enable git, ntpd.
* Create index.html.erb which dynamically gets IP address and hostname from Ohai.
* Sending and receiving notificaitons (subscribe, etc).
* Create simple unit test using chefspec and/or use of Chef Kitchen.

## Running ChefSpec tests.

1. SSH into server.
2. Enter the following commands.

```
$ cd /srv/playground/chef/apache
$ sudo chef exec rspec
```
