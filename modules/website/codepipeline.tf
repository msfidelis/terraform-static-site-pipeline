resource "aws_codepipeline" "prod_pipeline" {
  name     = "${var.app_name}-${var.git_repository_branch}-pipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  depends_on = ["aws_s3_bucket.bucket_site", "aws_s3_bucket.source"]
  
  artifact_store {
    location = "${aws_s3_bucket.source.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration {
        Owner  = "${var.git_repository_owner}"
        Repo   = "${var.git_repository_name}"
        Branch = "${var.git_repository_branch}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]

      configuration {
        ProjectName = "${var.app_name}-${var.git_repository_branch}-codebuild"
      }
    }
  }
}
