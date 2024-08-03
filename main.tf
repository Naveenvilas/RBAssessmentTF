provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "rbktksterraformstate" {
  bucket = "rbktksterraformstate"

}

resource "aws_s3_bucket_versioning" "rbktksterraformstate" {
  bucket = aws_s3_bucket.rbktksterraformstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "rbktksterraformstate" {
  bucket = aws_s3_bucket.rbktksterraformstate.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}