resource "aws_s3_bucket" "my-bucket" {
  bucket        = "${local.project_name}-bucket"
    tags = {
        Name        = "data bucket"
        Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.my-bucket.id
  acl    = "private"
}


resource "aws_s3_bucket" "athena_results" {
  bucket        = "${local.project_name}-bucket-athena-results"
    tags = {
        Name        = "athena query bucket"
        Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "athena_bucket" {
  bucket = aws_s3_bucket.athena_results.id
  acl    = "private"
}

