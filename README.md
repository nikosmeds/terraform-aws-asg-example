# Apache Server

## Summary

Use an EC2 auto scaling group to deploy an apache web server.

For more details on each section, read the relevant `README.md` files found in:
- `./chef/README.md`
- `./terraform/README.md`

## Usage

1. Clone this repository locally.
2. Update Terraform variables to match your desired AWS region and account ID.
3. Simply `cd terraform && terraform apply -target=module.vpc && terraform apply -target=module.apache`.

#### Provisoning Details

* Terraform provisions infrastructure.
* Terraform loads user-data onto the EC2 instance to:
-- install git, chefdk, and other requirements.
-- clone this `playground` repository to instance.
-- use `chef-solo` to self-apply cookbook.
