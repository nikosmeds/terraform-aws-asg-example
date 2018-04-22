module "vpc" {
  source = "./modules/vpc"

  name              = "Playground"
  vpc_cidr_block    = "${var.vpc_cidr_block}"
  subnet_cidr_block = "${var.subnet_cidr_block}"
}

module "apache" {
  source = "./modules/server"

  name      = "Apache Server"
  vpc_id    = "${module.vpc.id}"
  subnet_id = "${module.vpc.subnet_id}"

  key_name      = "${var.key_name}"
  whitelist_ips = "${var.whitelist_ips}"
}

output "public_dns" {
  description = "The public DNS name assigned to the instance."
  value       = "${module.apache.public_dns}"
}
