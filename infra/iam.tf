#Before we can create an AWS Glue Crawler, we need 
# to create an IAM role and attach IAM policies to 
#it with the correct permissions to run a Glue crawler job.

resource "aws_iam_role" "glue_s3_crawler_role" {
  name = "s3-glue-crawler"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "glue.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy" "AWSGlueServiceRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}


resource "aws_iam_role_policy_attachment" "glue" {
  role       = "${aws_iam_role.glue_s3_crawler_role.name}"
  policy_arn = "${data.aws_iam_policy.AWSGlueServiceRole.arn}"
}


data "aws_iam_policy_document" "glue-crawler-s3-access" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = [aws_s3_bucket.my-bucket.arn]
    effect = "Allow"
  }
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.my-bucket.arn}/*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "s3-policy" {
    name        = "glue-crawler-s3-policy"
    description = "glue-crawler-s3-policy"
    policy = data.aws_iam_policy_document.glue-crawler-s3-access.json
 }

resource "aws_iam_role_policy_attachment" "glue-s3-crawler-rpa" {
  role       = "${aws_iam_role.glue_s3_crawler_role.name}"
  policy_arn = "${aws_iam_policy.s3-policy.arn}"
}

