terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.58.0"
    }
  }

  backend "s3" {
    bucket = "my-tf-lock-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-2"
    encrypt      = true
    use_lockfile = true      
  }
}
