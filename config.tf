variable "app_name" {
  description = "Website project name"
  default     = "raj-personal-site"
}

variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "us-east-1"
}

variable "git_repository_owner" {
  description = "Github Repository Owner"
  default     = "msfidelis"
}

variable "git_repository_name" {
  description = "Project name on Github"
  default     = "msfidelis.github.io"
}

variable "git_repository_branch" {
  description = "Github Project Branch"
  default     = "master"
}

variable "git_repository_dev_branch" {
  description = "Github Project Branch"
  default     = "develop"
}
