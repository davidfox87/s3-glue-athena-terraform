resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "my_catalog_database"
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "example"
  role          = aws_iam_role.glue_s3_crawler_role.arn

  schedule = "cron(0 0 * * ? *)"
  
  description   = "create a Glue DB and the crawler to crawl an s3 bucket "
  s3_target {
    path = "s3://${aws_s3_bucket.my-bucket.bucket}"
  }
}



