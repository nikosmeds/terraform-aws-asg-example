module "vpc" {
  source = "./modules/vpc"

  name = "Playground"
}

module "apache" {
  source = "./modules/server"

  name           = "Apache Server"
  vpc_id         = "${module.vpc.id}"
  vpc_cidr_block = "${module.vpc.vpc_cidr}"
  subnet_id      = "${module.vpc.subnet_id}"
  whitelist_ips  = "${var.whitelist_ips}"
  key_name       = "${var.key_name}"
}

output "public_dns" {
  description = "The public DNS name assigned to load balancer."
  value       = "${module.apache.public_dns}"
}
