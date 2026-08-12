resource "aws_s3_bucket" "lock_state" {
  bucket = "my-tf-lock-state-bucket"

  tags = {
    Name        = "my-tf-lock-state-bucket"
    Environment = "Dev"
  }
}