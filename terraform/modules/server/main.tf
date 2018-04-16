resource "aws_instance" "server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.server.id}"]
  subnet_id              = "${var.subnet_id}"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y && apt upgrade -y && apt install tree -y
              wget -P /var/cache/apt/archives/ https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
              dpkg -i /var/cache/apt/archives/chefdk_2.5.3-1_amd64.deb
              git clone https://github.com/thesmeds/playground.git /srv/playground/
              chef-solo -c /srv/playground/chef/solo.rb -j /srv/playground/chef/web.json
              EOF

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
    cidr_blocks = ["108.172.6.157/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["108.172.6.157/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { Name = "${var.name}" }
}
