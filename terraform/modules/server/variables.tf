variable "ami" {
  description = "The AMI to use for the instance. Default is free-tier Ubuntu 16.04."
  type        = "string"
  default     = "ami-4e79ed36"
}

variable "instance_type" {
  description = "The type of EC2 instance to start."
  type        = "string"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key used to access the instance."
  type        = "string"
}

variable "name" {
  description = "A name used to identify the instance."
  type        = "string"
}

variable "subnet_id" {
  description = "The subnet ID in which we launch the instance."
  type        = "string"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = "string"
}

variable "vpc_id" {
  description = "The VPC ID in which we lauch the instance."
  type        = "string"
}

variable "whitelist_ips" {
  description = "The IP(s) granted access to the instance."
  type        = "list"
}
