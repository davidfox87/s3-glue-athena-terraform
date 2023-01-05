locals {
  project_name              = "s3-athena-data-test"
}

variable "aws-region" {
  type        = string
  default = "us-west-1"
}