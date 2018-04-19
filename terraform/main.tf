# TODO: Create `terraform.tfvars` to simply overwriting
# variable values.

module "vpc" {
  source = "./modules/vpc"

  name              = "Playground"
  vpc_cidr_block    = "10.0.0.0/16"
  subnet_cidr_block = "10.0.0.0/24"
}

module "apache" {
  source = "./modules/server"

  name      = "Apache Server"
  vpc_id    = "${module.vpc.id}"
  subnet_id = "${module.vpc.subnet_id}"
  # TODO: Create `key_name` variable, which is optional.
  # Ideally this is a no-ssh environment.
  key_name  = "nsmeds_acer"
}

output "public_dns" {
  description = "The public DNS name assigned to the instance."
  value       = "${module.apache.public_dns}"
}
