resource "aws_s3_bucket" "bucket_site" {

    bucket = "${var.app_name}-${var.account_id}-${var.git_repository_branch}"
    acl    = "public-read"
    force_destroy = true
    
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "GET", "DELETE"]
        allowed_origins = ["*"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

resource "aws_s3_bucket_policy" "bucket_site_policy" {
    bucket = "${aws_s3_bucket.bucket_site.id}"

    policy = <<POLICY
{
        "Version": "2008-10-17",
        "Id": "Allow-Public-Access-${var.app_name}-${var.account_id}",
        "Statement": [
            {
                "Sid": "Allow-Public-Access-${var.app_name}-${var.account_id}",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.bucket_site.arn}/*"
            }
        ]
    }
    POLICY

}