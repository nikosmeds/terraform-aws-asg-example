variable "aws_region" {
  description = "The AWS region."
  type        = "string"
  default     = "us-west-2"
}

variable "aws_account_ids" {
  description = "The white listed AWS account ID(s)."
  type        = "list"
  default     = ["952182316740"]
}
