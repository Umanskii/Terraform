#S3 backend
terraform {
  required_version = ">=1.2.4"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "terraformstatefile" #replace with your key
    bucket  = "ansibles3123123123" #replace with your bucket
  }
}

#Providers
provider "aws" {
  region = "us-east-1"
}
