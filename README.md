## Summary

* Terraform provisions an EC2 auto scaling group.
* Chef configures a basic apache web server.

## Usage

1. Clone this repository locally.
2. Ensure your AWS API access keys are defined in `~/.aws/credentials`.
3. Update `terraform/terraform.tfvars` variables with your AWS account ID and other optional parameters.
4. Use Terraform to provision infrastructure.

```
$ cd terraform/
$ terraform apply -target=module.vpc
$ terraform apply -target=module.apache
```

5. SSH into server and run ChefSpec tests.

```
$ ssh ubuntu@<ec2_dns>
$ cd /srv/playground/chef/apache
$ sudo chef exec rspec
```

6. Stress the CPU, which triggers ASG to spin up 2nd server.

```
$ stress -c 8
```

7. Afterwards, use Terraform to destroy infrastructure.

```
$ terraform destroy -target=module.apache
$ terraform destroy -target=module.vpc
```
