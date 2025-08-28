resource "random_string" "s3_suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "aws_s3_bucket" "feast_bucket" {
  # Since bucket names are globally unique, we add a random suffix here.
  bucket = "${var.name_prefix}-feast-${random_string.s3_suffix.result}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
request_payer = "Requester"
force_destroy = "CUSTOMER_INPUT"
}
resource "aws_s3_bucket_public_access_block" "my_aws_s3_bucket_public_access_block_aws_s3_bucket_feast_bucket" {
bucket = aws_s3_bucket.feast_bucket.id
ignore_public_acls = true
}
resource "aws_s3_bucket_versioning" "my_aws_s3_bucket_versioning_aws_s3_bucket_feast_bucket" {
bucket = aws_s3_bucket.feast_bucket.id
versioning_configuration {
status = "Enabled"
}
}