data "template_file" "prod_buildspec" {
  template = "${file("${path.module}/templates/buildspec.yml")}"

  vars {
    app_name    = "${var.app_name}"
    stage       = "${var.git_repository_branch}"
    bucket_name = "${aws_s3_bucket.bucket_site.bucket}"
    // distribuition_id = "${aws_cloudfront_distribution.prod_s3_distribution.id}"
  }
}

resource "aws_codebuild_project" "prod_app_build" {
  name          = "${var.app_name}-${var.git_repository_branch}-codebuild"
  build_timeout = "80"
  service_role = "${aws_iam_role.codebuild_role.arn}"

  depends_on = ["aws_s3_bucket.bucket_site", "aws_s3_bucket.source"]

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    // https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image           = "aws/codebuild/nodejs:8.11.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "${data.template_file.prod_buildspec.rendered}"
  }
}

resource "aws_s3_bucket" "source" {
  bucket        = "${var.app_name}-${var.git_repository_branch}-pipeline"
  acl           = "private"
  force_destroy = true
}