# TODO: Create `profile` variable. Not all users will set
# desired AWS account as `default` in `~/.aws/credentials`.

provider "aws" {
  region              = "${var.aws_region}"
  allowed_account_ids = "${var.aws_account_ids}"
}
