terraform {
  backend "s3" {
    bucket = "terra-javapp-state"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}