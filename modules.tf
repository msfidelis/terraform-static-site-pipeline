
module "production" {
  source                        = "./modules/production"
  app_name                      = "${var.app_name}"
  aws_region                    = "${var.aws_region}"
  git_repository_owner          = "${var.git_repository_owner}"
  git_repository_name           = "${var.git_repository_name}"
  git_repository_branch         = "${var.git_repository_branch}"
  git_repository_dev_branch     = "${var.git_repository_dev_branch}"
  account_id                    = "${data.aws_caller_identity.current.account_id}"
}