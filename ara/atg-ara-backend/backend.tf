provider "aws" {
    region = var.region
}

resource "aws_s3_bucket" "backend_s3_dev" {
  bucket = "${var.client_name}-dev-tf-state-bucket"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }  
  tags = {
    Name        = var.client_name
    Environment = "dev"
    AWSBackup  = "True"
  }
}
resource "aws_s3_bucket_versioning" "version_dev" {
  bucket = aws_s3_bucket.backend_s3_dev.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_policy" "deny_delete_bucket_dev" {
  bucket = aws_s3_bucket.backend_s3_dev.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "${aws_s3_bucket.backend_s3_dev.arn}"
    }
  ]
}
EOF
}
resource "aws_dynamodb_table" "statelock_dev" {
  name           = "${var.client_name}-dev-tf-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = var.client_name
    Environment = "dev"
    AWSBackup  = "True"
  }
}

resource "aws_s3_bucket" "backend_s3_prod" {
  bucket = "${var.client_name}-prod-tf-state-bucket"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }     
  tags = {
    Name        = var.client_name
    Environment = "production"
    AWSBackup  = "True"
  }
}
resource "aws_s3_bucket_versioning" "version_prod" {
  bucket = aws_s3_bucket.backend_s3_prod.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_policy" "deny_delete_bucket_prod" {
  bucket = aws_s3_bucket.backend_s3_prod.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "${aws_s3_bucket.backend_s3_prod.arn}"
    }
  ]
}
EOF
}
resource "aws_dynamodb_table" "statelock_prod" {
  name           = "${var.client_name}-prod-tf-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = var.client_name
    Environment = "production"
    AWSBackup  = "True"
  }
}

resource "aws_s3_bucket" "backend_s3_stage" {
  bucket = "${var.client_name}-stage-tf-state-bucket"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }  
  tags = {
    Name        = var.client_name
    Environment = "stage"
    AWSBackup  = "True"
  }
}
resource "aws_s3_bucket_versioning" "version_stage" {
  bucket = aws_s3_bucket.backend_s3_stage.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_policy" "deny_delete_bucket_stage" {
  bucket = aws_s3_bucket.backend_s3_stage.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "${aws_s3_bucket.backend_s3_stage.arn}"
    }
  ]
}
EOF
}
resource "aws_dynamodb_table" "statelock_stage" {
   name           = "${var.client_name}-stage-tf-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = var.client_name
    Environment = "stage"
    AWSBackup  = "True"
  }
}