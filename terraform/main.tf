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
  key_name  = "nsmeds_acer"
}
