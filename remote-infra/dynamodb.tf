resource "aws_dynamodb_table" "remote-terrafrom-dynamodb-table" {
  name           = "my-tf-lock-state-dynamotable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}