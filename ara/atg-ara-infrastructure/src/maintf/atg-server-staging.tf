provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-southeast-2"
    encrypt        = true
    key            = "tfstate"
    bucket         = "ara-staging-tf-state-bucket"
    dynamodb_table = "ara-staging-tf-locks"
  }
}

