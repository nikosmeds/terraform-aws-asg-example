resource "aws_launch_configuration" "server" {
  name_prefix                 = "server-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.server.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/user-data.sh")}"
}

resource "aws_autoscaling_policy" "server_scale_down" {
  name                   = "server-scale-down"
  autoscaling_group_name = "${aws_autoscaling_group.server.name}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  scaling_adjustment     = -1
}

resource "aws_autoscaling_policy" "server_scale_up" {
  name                   = "server-scale-up"
  autoscaling_group_name = "${aws_autoscaling_group.server.name}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  scaling_adjustment     = 1
}

resource "aws_cloudwatch_metric_alarm" "server_scale_down" {
  alarm_name          = "server-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 20
  alarm_actions       = ["${aws_autoscaling_policy.server_scale_down.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.server.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "server_scale_up" {
  alarm_name          = "server-scale-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  alarm_actions       = ["${aws_autoscaling_policy.server_scale_up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.server.name}"
  }
}

resource "aws_autoscaling_group" "server" {
  name_prefix          = "server-"
  max_size             = 2
  min_size             = 1
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.server.name}"
  load_balancers       = ["${aws_elb.server_lb.name}"]
  vpc_zone_identifier  = ["${var.subnet_id}"]

  tags {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_elb" "server_lb" {
  name_prefix     = "serv-"
  security_groups = ["${aws_security_group.server_lb.id}"]
  subnets         = ["${var.subnet_id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags { Name = "${var.name}" }
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
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.server_lb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { Name = "${var.name}" }
}

resource "aws_security_group" "server_lb" {
  name_prefix = "server_lb-"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.whitelist_ips}"
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    # We would prefer to restrict traffic to the `server`
    # security group but that introduces a cyclic dependency.
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  tags { Name = "${var.name}" }
}

output "public_dns" {
  description = "The public DNS name assigned to load balancer."
  value       = "${aws_elb.server_lb.dns_name}"
}
