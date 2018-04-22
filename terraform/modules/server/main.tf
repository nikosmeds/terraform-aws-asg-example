# TODO:
# Move from EC2 instance to auto scaling group.
# Create auto scaling rules for 40% CPU.
# Place ELB in front of ASG.

resource "aws_instance" "server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.server.id}"]
  subnet_id              = "${var.subnet_id}"
  user_data              = "${file("${path.module}/user-data.sh")}"

  tags        { Name = "${var.name}" }
  volume_tags { Name = "${var.name}" }
}

resource "aws_security_group" "server" {
  name_prefix = "server-"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.whitelist_ips}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.whitelist_ips}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { Name = "${var.name}" }
}

output "public_dns" {
  description = "The public DNS name assigned to the instance."
  value       = "${aws_instance.server.public_dns}"
}
