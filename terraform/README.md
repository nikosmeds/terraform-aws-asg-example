# Apacher Server: Terraform

## Terraform provisions

* An AWS VPC and related network resources required for a public web server.
* An EC2 autoscaling group, load balancer, and security group.

For ease of development, the VPC and ASG components have been separated. We can spin up or tear down the ASG and related resources with a single command. Both `vpc` and `server` modules are built to be generic and reusable (improvements pending).

## Usage

We will use `~/.aws/credentials` to define our API access keys.

#### Create resources

```bash
terraform apply -target=module.vpc
terraform apply -target=module.apache
```

#### Destroy resources

```bash
terraform destory -target=module.apache
terraform destory -target=module.vpc
```
