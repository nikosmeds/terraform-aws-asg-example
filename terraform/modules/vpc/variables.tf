variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = "string"
  default     = "true"
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = "string"
  default     = "true"
}

variable "name" {
  description = "A name used to identify the VPC."
  type        = "string"
} 

variable "subnet_cidr_block" {
  description = "The CIDR block for public subnet."
  type        = "string"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = "string"
}
