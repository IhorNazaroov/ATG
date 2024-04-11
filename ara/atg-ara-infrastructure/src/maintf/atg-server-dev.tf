provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-southeast-2"
    encrypt        = true
    key            = "tfstate"
    bucket         = "ara-dev-tf-state-bucket"
    dynamodb_table = "ara-dev-tf-locks"
  }
}
