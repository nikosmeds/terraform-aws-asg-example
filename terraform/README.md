# Summary

Terraform provisions:
- a VPC and network resources required for a public web server.
- an autoscaling group to be configured as a web server sitting behind a load balancer.

For ease of development, the VPC and ASG components have been separated. We can spin up or tear down the ASG and related resources with a single command. Both `vpc` and `server` modules are built to be generic and reusable (though improvements can always be made).

# Usage

terraform apply -target=module.vpc
terraform apply -target=module.apache

terraform destory -target=module.apache
terraform destory -target=module.vpc
