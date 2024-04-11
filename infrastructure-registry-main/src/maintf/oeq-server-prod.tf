provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-southeast-2"
    encrypt        = true
    key            = "tfstate"
    bucket         = "infra-registry-prod-tf-backend-state-bucket"
    dynamodb_table = "infra-registry-prod-tf-backend-locks"
  }
}
