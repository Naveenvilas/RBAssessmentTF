terraform {
  backend "s3" {
    bucket = "RBK-Bucket"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-lock"
  }
}
