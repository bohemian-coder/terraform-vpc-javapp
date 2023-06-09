# S3 bucket initialization to save cloud state
terraform {
  backend "s3" {
    bucket = "terra-javapp-state"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}