resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags { Name = "${var.name}" }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags { Name = "${var.name}" }
}

resource "aws_route" "main" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

# TODO: Create two subnets in separate availability zones. Ideally
# we'd also create private subnets, however they are not required
# for such a simple environment (public web server behind ELB).
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = true

  tags { Name = "${var.name}" }
}

output "subnet_id" {
  description = "The ID of the public subnet."
  value       = "${aws_subnet.public.id}"
}

output "id" {
  description = "The ID of the VPC."
  value       = "${aws_vpc.main.id}"
}
