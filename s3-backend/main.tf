provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf-remote-state" {
  bucket        = "tf-remote-s3-bucket-simaox"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mybackend-enc" {
  bucket = aws_s3_bucket.tf-remote-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_backend_s3" {
  bucket = aws_s3_bucket.tf-remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  hash_key     = "LockID"
  name         = "tf-s3-app-lock"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}