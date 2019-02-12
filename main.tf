provider "aws" {
  region = "${var.aws_region}"
}

// Account infos reference
data "aws_caller_identity" "current" {}