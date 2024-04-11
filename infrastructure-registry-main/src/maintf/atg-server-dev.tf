provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-southeast-2"
    encrypt        = true
    key            = "tfstate"
    bucket         = "infra-registry-dev-tf-state-bucket"
    dynamodb_table = "infra-registry-dev-tf-locks"
  }
}
